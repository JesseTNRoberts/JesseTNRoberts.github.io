#!/usr/bin/env ruby
# frozen_string_literal: true

# Refreshes _data/stats.yml with live numbers for the homepage trackers.
#
#   publications  papers dated in the tracker year on Google Scholar, via SerpApi if
#                 SERPAPI_KEY is set (Scholar blocks GitHub's servers directly), else a
#                 direct Scholar request. Scholar is the only source.
#                 A successful Scholar fetch also rewrites _data/publications.yml,
#                 the list shown on the Publications page.
#   strava        year-to-date running miles from Strava's totals (public activities only)
#
# Each source is independent: if one fails, its previous values in stats.yml are kept
# and marked stale, so the site never shows a zero because an API hiccuped.
#
# Configuration
#   _data/goals.yml   year
#   _config.yml       author.googlescholar (profile URL)
#   env               SERPAPI_KEY (optional; https://serpapi.com, free plan is enough)
#                     STRAVA_CLIENT_ID, STRAVA_CLIENT_SECRET, STRAVA_REFRESH_TOKEN
#                     (Strava is skipped if these aren't set; see scripts/strava_auth.rb)
#
# Usage: ruby scripts/update_stats.rb   (run from the repo root)
# Only the Ruby standard library is used, so no gems are needed.

require "yaml"
require "json"
require "net/http"
require "uri"
require "time"
require "date"

ROOT = File.expand_path("..", __dir__)
STATS_PATH = File.join(ROOT, "_data", "stats.yml")
PUBS_PATH = File.join(ROOT, "_data", "publications.yml")
UA = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) " \
     "Chrome/128.0 Safari/537.36"
METERS_PER_MILE = 1609.344

class FetchError < StandardError; end

def log(msg)
  warn("[stats] #{msg}")
  # In GitHub Actions, also surface each message as an annotation on the run's summary page.
  puts "::notice title=stats::#{msg.gsub("\n", " ")}" if ENV["GITHUB_ACTIONS"]
end

def http_get(url, headers = {})
  uri = URI(url)
  req = Net::HTTP::Get.new(uri)
  req["User-Agent"] = UA
  headers.each { |k, v| req[k] = v }
  res = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https",
                        open_timeout: 15, read_timeout: 30) { |h| h.request(req) }
  unless res.is_a?(Net::HTTPSuccess)
    # Include the service's own error message if it sent one (never the URL's query, which may hold a key)
    body = (JSON.parse(res.body) rescue {})
    body = {} unless body.is_a?(Hash)
    # SerpApi: {"error": "..."}; Strava: {"message": "...", "errors": [{"field": "activity:read_permission", "code": "missing"}]}
    detail = body["error"] || [body["message"], *Array(body["errors"]).map { |e| [e["field"], e["code"]].compact.join(" ") }].compact.join(": ")
    detail = nil if detail.to_s.empty?
    raise FetchError, "GET #{uri.host}#{uri.path} -> HTTP #{res.code}#{detail ? " (#{detail})" : ''}"
  end

  res.body.force_encoding("UTF-8")
end

def http_post_form(url, form)
  res = Net::HTTP.post_form(URI(url), form)
  raise FetchError, "POST #{url} -> HTTP #{res.code}" unless res.is_a?(Net::HTTPSuccess)

  JSON.parse(res.body)
end

# ---------------------------------------------------------------- publications

def scholar_user_id(config)
  url = config.dig("author", "googlescholar").to_s
  url[/[?&]user=([\w-]+)/, 1]
end

def strip_tags(s)
  s.to_s.gsub(/<[^>]+>/, "").gsub("&amp;", "&").gsub("&#39;", "'").gsub("&quot;", '"')
   .gsub("&lt;", "<").gsub("&gt;", ">").gsub("&nbsp;", " ").gsub("&hellip;", "…").squeeze(" ").strip
end

# Parses one Scholar profile page into { papers: [...], citations: Integer|nil }.
#
# A paper row looks like:
#   <tr class="gsc_a_tr">
#     <td class="gsc_a_t"><a href="/citations?view_op=view_citation&..." class="gsc_a_at">Title</a>
#       <div class="gs_gray">J Roberts, D Fisher</div>
#       <div class="gs_gray">Proceedings of AAAI 38 (17), 1-9<span class="gs_oph">, 2024</span></div></td>
#     <td class="gsc_a_c"><a href="..." class="gsc_a_ac gs_ibl">12</a></td>
#     <td class="gsc_a_y"><span class="gsc_a_h gsc_a_hc gs_ibl">2024</span></td>
#   </tr>
def parse_scholar(html)
  if html.include?("gs_captcha") || html =~ /unusual traffic|not a robot/i
    raise FetchError, "Google Scholar returned a CAPTCHA"
  end

  rows = html.scan(%r{<tr class="gsc_a_tr[^"]*".*?</tr>}m)
  raise FetchError, "couldn't find any publications on the Scholar page (layout changed?)" if rows.empty?

  papers = rows.map do |r|
    link = r[%r{<a[^>]*href="([^"]+)"[^>]*class="gsc_a_at"}, 1] || r[%r{<a[^>]*class="gsc_a_at"[^>]*href="([^"]+)"}, 1]
    gray = r.scan(%r{<div class="gs_gray">(.*?)</div>}m).flatten
    {
      "title" => strip_tags(r[%r{class="gsc_a_at"[^>]*>(.*?)</a>}m, 1]),
      "authors" => strip_tags(gray[0]),
      # drop the ", 2024" Scholar appends to the venue line
      "venue" => strip_tags(gray[1].to_s.sub(%r{<span class="gs_oph">.*?</span>}m, "")),
      "year" => r[%r{class="gsc_a_y[^"]*".*?>\s*((?:19|20)\d\d)\s*<}m, 1]&.to_i,
      "cited_by" => r[%r{class="gsc_a_ac[^"]*"[^>]*>\s*(\d+)\s*<}, 1].to_i,
      "url" => link && "https://scholar.google.com#{link.gsub('&amp;', '&')}"
    }
  end
  # First cell of the "Cited by" table is all-time citations.
  citations = html[%r{class="gsc_rsb_std[^"]*"[^>]*>\s*(\d+)\s*<}, 1]&.to_i

  { papers: papers, citations: citations }
end

def fetch_scholar(user_id, year)
  raise FetchError, "no Google Scholar profile URL in _config.yml" unless user_id

  papers = []
  citations = nil
  # Scholar shows up to 100 papers per page; loop in case the profile grows past that.
  (0..900).step(100) do |start|
    url = "https://scholar.google.com/citations?user=#{user_id}&hl=en&cstart=#{start}&pagesize=100&sortby=pubdate"
    page = parse_scholar(http_get(url, "Accept-Language" => "en-US,en;q=0.9"))
    papers.concat(page[:papers])
    citations ||= page[:citations]
    break if page[:papers].size < 100

    sleep 2
  end
  write_publications(papers, user_id)
  { "papers_this_year" => papers.count { |p| p["year"] == year }, "papers_total" => papers.size,
    "citations" => citations, "source" => "Google Scholar" }
end

# Full publication list for the Publications page (_includes/scholar-publications.html).
# Only written after a successful Scholar fetch, so a blocked request never wipes the list.
def write_publications(papers, user_id)
  sorted = papers.sort_by { |p| [-(p["year"] || 0), p["title"].downcase] }
  data = { "profile" => "https://scholar.google.com/citations?user=#{user_id}",
           "updated" => Time.now.utc.iso8601, "papers" => sorted }
  header = "# Generated from Google Scholar by scripts/update_stats.rb (daily via GitHub Actions).\n" \
           "# Don't edit by hand. To fix a paper, edit it on your Scholar profile.\n"
  File.write(PUBS_PATH, header + data.to_yaml.sub(/\A---\n/, ""))
  log "wrote #{papers.size} papers to #{PUBS_PATH}"
end

# Google Scholar blocks requests from GitHub's servers (HTTP 403), so the reliable way to
# mirror the profile is SerpApi's Google Scholar Author API (free plan: 250 searches/month;
# this uses ~1 per day). Set the SERPAPI_KEY repo secret to enable it.
def fetch_serpapi(user_id, year)
  key = ENV["SERPAPI_KEY"].to_s.strip
  raise FetchError, "SERPAPI_KEY not set" if key.empty?
  raise FetchError, "no Google Scholar profile URL in _config.yml" unless user_id

  papers = []
  citations = nil
  (0..900).step(100) do |start|
    url = "https://serpapi.com/search.json?engine=google_scholar_author&author_id=#{user_id}" \
          "&hl=en&sort=pubdate&num=100&start=#{start}&api_key=#{key}"
    data = JSON.parse(http_get(url))
    raise FetchError, "SerpApi: #{data['error']}" if data["error"]

    citations ||= data.dig("cited_by", "table", 0, "citations", "all")
    arts = data["articles"] || []
    arts.each do |a|
      year_i = a["year"].to_s[/\d{4}/]&.to_i
      papers << {
        "title" => a["title"].to_s.strip,
        "authors" => a["authors"].to_s.strip,
        "venue" => a["publication"].to_s.sub(/,\s*(?:19|20)\d\d\s*\z/, "").strip,
        "year" => year_i,
        "cited_by" => a.dig("cited_by", "value").to_i,
        "url" => a["link"]
      }
    end
    break if arts.size < 100
  end
  raise FetchError, "SerpApi returned no articles" if papers.empty?

  write_publications(papers, user_id)
  { "papers_this_year" => papers.count { |p| p["year"] == year }, "papers_total" => papers.size,
    "citations" => citations, "source" => "Google Scholar" }
end

# Scholar is the only source for publications (it's the curated one). Tries SerpApi first
# (works from GitHub's servers), then a direct request. If both fail, the last good Scholar
# numbers and list are kept.
def fetch_publications(config, year)
  user_id = scholar_user_id(config)
  errors = []
  [-> { fetch_serpapi(user_id, year) }, -> { fetch_scholar(user_id, year) }].each do |source|
    return source.call
  rescue StandardError => e
    errors << e.message
  end
  raise FetchError, errors.join("; ")
end

# ---------------------------------------------------------------------- strava

def strava_access_token
  id, secret, refresh = ENV.values_at("STRAVA_CLIENT_ID", "STRAVA_CLIENT_SECRET", "STRAVA_REFRESH_TOKEN")
  raise FetchError, "Strava secrets not set (skipping)" if [id, secret, refresh].any? { |v| v.to_s.empty? }

  tok = http_post_form("https://www.strava.com/oauth/token",
                       "client_id" => id, "client_secret" => secret,
                       "grant_type" => "refresh_token", "refresh_token" => refresh)
  if tok["refresh_token"] && tok["refresh_token"] != refresh
    log "Strava issued a new refresh token; update the STRAVA_REFRESH_TOKEN secret if Strava starts failing"
  end
  tok.fetch("access_token")
end

# Uses Strava's athlete-stats endpoint, which returns only year-to-date totals (no routes,
# maps, times, or individual activities) and needs only the basic "read" permission.
# Strava counts only activities visible to Everyone, and all run types (Run, TrailRun, ...)
# together, for the current calendar year.
def fetch_strava(year)
  raise FetchError, "Strava only reports totals for the current year" unless year == Time.now.year

  token = strava_access_token
  auth = { "Authorization" => "Bearer #{token}" }
  athlete_id = JSON.parse(http_get("https://www.strava.com/api/v3/athlete", auth)).fetch("id")
  stats = JSON.parse(http_get("https://www.strava.com/api/v3/athletes/#{athlete_id}/stats", auth))
  runs = stats.fetch("ytd_run_totals")
  { "miles_this_year" => (runs["distance"].to_f / METERS_PER_MILE).round(1), "activities" => runs["count"].to_i }
end

# ------------------------------------------------------------------------ main

def main
  config = YAML.safe_load_file(File.join(ROOT, "_config.yml"), aliases: true)
  goals = YAML.safe_load_file(File.join(ROOT, "_data", "goals.yml"), permitted_classes: [Date])
  year = (goals["year"] || Date.today.year).to_i

  old = File.exist?(STATS_PATH) ? (YAML.safe_load_file(STATS_PATH, permitted_classes: [Time, Date]) || {}) : {}
  old = {} unless old["year"].to_i == year # new year: don't carry last year's totals forward
  old.delete("publications") unless old.dig("publications", "source") == "Google Scholar"
  now = Time.now.utc.iso8601
  stats = { "year" => year }
  changed = false

  { "publications" => -> { fetch_publications(config, year) },
    "strava" => -> { fetch_strava(year) } }.each do |key, fetcher|
    fresh = fetcher.call
    log "#{key}: #{fresh.inspect}"
    stats[key] = fresh.merge("updated" => now)
    changed = true
  rescue StandardError => e
    log "#{key} not updated: #{e.message}"
    stats[key] = old[key] if old[key] # keep the last good numbers
  end

  unless changed
    log "nothing fetched; leaving #{STATS_PATH} untouched"
    return
  end

  header = "# Generated by scripts/update_stats.rb (daily via GitHub Actions). Don't edit by hand;\n" \
           "# targets and manual numbers live in _data/goals.yml.\n"
  File.write(STATS_PATH, header + stats.to_yaml.sub(/\A---\n/, ""))
  log "wrote #{STATS_PATH}"
end

main if $PROGRAM_NAME == __FILE__
