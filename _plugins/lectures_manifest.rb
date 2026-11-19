# Published lectures live in the JesseTNRoberts/lectures repo, served at /lectures/, with a list
# in its lectures.yml (one list per course_id). This generator reads that list at build time and
# merges it into each course file's `lectures:` (matched by week and session, the list wins), so
# course pages, the lecture library and course cards are built from it. The Teaching page and
# course pages also re-read the list in the browser (_includes/lectures-live.html), so a lecture
# added to the lectures repo shows up before the next build.
#
# If the list can't be fetched the build fails on purpose, so a deploy never drops the lectures.
# Local builds without network can set LECTURES_MANIFEST_FILE to a copy, or
# LECTURES_MANIFEST_SKIP=1 to build without it.
require "json"
require "yaml"
require "date"
require "net/http"
require "uri"

module LecturesManifest
  URL = "https://raw.githubusercontent.com/JesseTNRoberts/lectures/main/lectures.yml".freeze
  PATH_KEYS = %w[slides notebook pdf].freeze

  def self.load
    if (f = ENV["LECTURES_MANIFEST_FILE"]) && !f.empty?
      return parse(File.read(f, encoding: "UTF-8"))
    end
    uri = URI(ENV["LECTURES_MANIFEST_URL"] || URL)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https",
                          open_timeout: 15, read_timeout: 30) do |http|
      http.get(uri.request_uri, "Cache-Control" => "no-cache")
    end
    raise "HTTP #{res.code}" unless res.is_a?(Net::HTTPSuccess)
    parse(res.body.force_encoding("UTF-8"))
  end

  # A map of course_id to lecture lists. Older lists had them under a "courses" key.
  def self.parse(text)
    data = YAML.safe_load(text, permitted_classes: [Date]) || {}
    raise "the top level should be course ids" unless data.is_a?(Hash)
    data = data["courses"] if data["courses"].is_a?(Hash)
    data
  end

  def self.normalize(entry)
    e = entry.reject { |k, _| k.start_with?("_") }
    PATH_KEYS.each do |k|
      v = e[k]
      next unless v.is_a?(String) && !v.empty?
      e[k] = "/lectures/#{v.sub(%r{\A/+}, '')}" unless v.start_with?("/", "http://", "https://")
    end
    e
  end

  def self.key(l)
    [l["week"].to_s, l["session"].to_s]
  end

  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      return if ENV["LECTURES_MANIFEST_SKIP"] == "1"
      begin
        data = LecturesManifest.load
      rescue StandardError => e
        raise "Couldn't read the lectures list (lectures.yml in the lectures repo) (#{e.class}: #{e.message}). " \
              "Set LECTURES_MANIFEST_SKIP=1 to build without it."
      end
      courses = data
      col = site.collections["teaching"]
      return unless col

      col.docs.each do |doc|
        entries = courses[doc.data["course_id"].to_s]
        next unless entries.is_a?(Array) && !entries.empty?
        list = (doc.data["lectures"] || []).map { |l| l.is_a?(Hash) ? l.dup : l }
        entries.each do |raw|
          next unless raw.is_a?(Hash)
          e = LecturesManifest.normalize(raw)
          i = list.index { |l| l.is_a?(Hash) && LecturesManifest.key(l) == LecturesManifest.key(e) }
          i ? list[i] = list[i].merge(e) : list << e
        end
        doc.data["lectures"] = list.each_with_index.sort_by do |l, idx|
          w = l.is_a?(Hash) ? l["week"] : nil
          s = l.is_a?(Hash) ? l["session"] : nil
          [w.to_s =~ /\A\d+\z/ ? w.to_i : 10_000, s.to_s =~ /\A\d+\z/ ? s.to_i : 0, idx]
        end.map(&:first)
      end
      Jekyll.logger.info "Lectures:", "merged lectures.yml for #{courses.keys.join(', ')}"
    end
  end
end
