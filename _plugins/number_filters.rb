# Liquid filter: {{ 195769 | number_with_delimiter }} -> "195,769" (used by the CV's Grants section).
module NumberFilters
  def number_with_delimiter(n)
    n.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
  end
end
Liquid::Template.register_filter(NumberFilters)
