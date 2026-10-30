# frozen_string_literal: true

# Annotates the Google Scholar mirror (_data/publications.yml) at build time:
#   - each paper gets `tier`, `label` and `note` from _data/venues.yml and
#     _data/publication_overrides.yml, plus a stable `key` and a numeric `sort_year`;
#   - each paper gets `areas` (ids from _data/research.yml) by title keywords or an override;
#   - hidden papers are dropped.
# Keeping this at build time means editing the rules never needs a new Scholar fetch.
module JesseSite
  class PublicationTiers < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      pubs = site.data["publications"]
      return unless pubs.is_a?(Hash) && pubs["papers"].is_a?(Array)

      venues = site.data["venues"] || {}
      rules = venues["rules"] || []
      overrides = site.data["publication_overrides"] || []
      areas = (site.data["research"] || {})["areas"] || []

      papers = pubs["papers"].map do |paper|
        p = paper.dup
        venue = p["venue"].to_s
        rule = rules.find { |r| r["match"] && venue.downcase.include?(r["match"].to_s.downcase) }
        p["tier"] = if rule then rule["tier"].to_i
                    elsif venue.strip.empty? then (venues["empty_venue_tier"] || 3).to_i
                    else (venues["default_tier"] || 2).to_i
                    end
        p["label"] = rule && rule["label"]

        overrides.each do |o|
          next unless o["title"] && p["title"].to_s.downcase.include?(o["title"].to_s.downcase)

          p["tier"] = o["tier"].to_i if o.key?("tier")
          p["label"] = o["label"] if o.key?("label")
          p["note"] = o["note"] if o.key?("note")
          p["hide"] = o["hide"] if o.key?("hide")
          p["areas"] = Array(o["areas"]) if o.key?("areas")
        end

        unless p.key?("areas")
          title = p["title"].to_s.downcase
          p["areas"] = areas.select { |a| Array(a["keywords"]).any? { |k| title.include?(k.to_s.downcase) } }
                            .map { |a| a["id"] }
        end

        p["sort_year"] = p["year"].to_i
        p["cited_by"] = p["cited_by"].to_i
        p["key"] = p["title"].to_s.downcase.gsub(/[^a-z0-9]+/, "-")[0, 60]
        p
      end

      papers.reject! { |p| p["hide"] }
      pubs["papers"] = papers

      # Per research area: how many papers, and which to showcase (the area's `selected` title
      # fragments, in order; otherwise its most-cited papers).
      areas.each do |a|
        tagged = papers.select { |p| p["areas"].include?(a["id"]) }
        picks = Array(a["selected"]).map do |frag|
          tagged.find { |p| p["title"].to_s.downcase.include?(frag.to_s.downcase) } ||
            papers.find { |p| p["title"].to_s.downcase.include?(frag.to_s.downcase) }
        end.compact.uniq
        picks = tagged.sort_by { |p| [-p["cited_by"], -p["sort_year"]] }.first(5) if picks.empty?
        a["paper_count"] = tagged.size
        a["selected_papers"] = picks
        # For the Research page's side panel: the area's most-cited papers and its total citations.
        a["top_papers"] = most_cited(tagged).first(10)
        a["citation_total"] = tagged.sum { |p| p["cited_by"] }
      end
      pubs["top_papers"] = most_cited(papers).first(10)
      pubs["paper_count"] = papers.size
      Jekyll.logger.info "Publications:", "#{papers.size} papers"
    end

    private

    # Most cited first, then newest, then title, so the order is stable between builds.
    def most_cited(list)
      list.sort_by { |p| [-p["cited_by"], -p["sort_year"], p["title"].to_s] }
    end
  end
end
