# Groups the synced Torch Canvas examples (_data/torch_canvas_library.json) into the categories
# defined in _data/torch_canvas.yml, for the Torch Canvas page. Each category gets `networks` and
# `blocks`; anything unmatched lands in a final "More examples" category.
module TorchCanvasCategories
  class Generator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      lib = site.data["torch_canvas_library"]
      conf = site.data["torch_canvas"] || {}
      return unless lib

      cats = (conf["categories"] || []).map do |c|
        c.merge("networks" => [], "blocks" => [], "ids" => Array(c["ids"]), "match" => Array(c["match"]))
      end
      other = { "id" => "more", "title" => "More examples", "icon" => "fas fa-shapes",
                "blurb" => "", "networks" => [], "blocks" => [], "ids" => [], "match" => [] }

      { "networks" => lib["networks"] || [], "blocks" => lib["blocks"] || [] }.each do |kind, items|
        items.each do |m|
          id = m["id"].to_s.downcase
          cat = cats.find { |c| c["ids"].include?(id) } ||
                cats.find { |c| c["match"].any? { |w| id.include?(w.to_s.downcase) } } ||
                other
          m["category"] = cat["id"]
          cat[kind] << m
        end
      end

      cats << other
      site.data["torch_canvas_categories"] =
        cats.reject { |c| c["networks"].empty? && c["blocks"].empty? }
    end
  end
end
