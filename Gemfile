source "https://rubygems.org"

# Built and deployed by .github/workflows/pages.yml (GitHub Actions), so we can use
# current Jekyll instead of the frozen `github-pages` gem.
#
# Local preview:
#   bundle install
#   bundle exec jekyll serve --livereload

gem "jekyll", "~> 4.4"
gem "webrick", "~> 1.8" # needed by `jekyll serve` on Ruby 3+

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-sitemap"
  gem "jekyll-seo-tag"
  gem "jekyll-redirect-from"
  gem "jekyll-paginate"
end

platforms :windows, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
  gem "wdm", "~> 0.1"
end
