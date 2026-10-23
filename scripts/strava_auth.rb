#!/usr/bin/env ruby
# One-time helper: get a Strava refresh token so the daily build can read your year-to-date
# running totals. It asks only for Strava's basic "read" permission: no access to individual
# activities, routes, maps, or private activities.
#
# 1. Go to https://www.strava.com/settings/api and create an app.
#    Any name and website work; set "Authorization Callback Domain" to: localhost
#    Note the Client ID and Client Secret it shows you.
# 2. On your computer, from this repo:
#       ruby scripts/strava_auth.rb CLIENT_ID CLIENT_SECRET
#    Open the link it prints, click Authorize, then copy the address your browser lands on
#    (it starts with http://localhost/exchange_token and the page won't load; that's expected)
#    and paste it back into the terminal.
# 3. In GitHub: repo Settings -> Secrets and variables -> Actions -> New repository secret.
#    Add STRAVA_CLIENT_ID, STRAVA_CLIENT_SECRET, and STRAVA_REFRESH_TOKEN with the values printed.
#
# Uses only the Ruby standard library (works with the Ruby that ships with macOS).

require "net/http"
require "uri"
require "json"

id, secret = ARGV
abort "Usage: ruby scripts/strava_auth.rb CLIENT_ID CLIENT_SECRET" unless id && secret

authorize = "https://www.strava.com/oauth/authorize?client_id=#{id}&response_type=code" \
            "&redirect_uri=http://localhost/exchange_token&approval_prompt=force&scope=read"
puts "\n1) Open this link and click Authorize:\n\n   #{authorize}\n\n"
print "2) Paste the address your browser landed on (http://localhost/exchange_token?...):\n   > "
answer = $stdin.gets.to_s.strip
code = answer[/[?&]code=([^&\s]+)/, 1] || answer
abort "No code found in what you pasted." if code.empty?

res = Net::HTTP.post_form(URI("https://www.strava.com/oauth/token"),
                          "client_id" => id, "client_secret" => secret,
                          "code" => code, "grant_type" => "authorization_code")
body = JSON.parse(res.body) rescue {}
abort "Strava said: HTTP #{res.code} #{res.body}" unless res.is_a?(Net::HTTPSuccess) && body["refresh_token"]

name = [body.dig("athlete", "firstname"), body.dig("athlete", "lastname")].compact.join(" ")
puts "\nAuthorized#{name.empty? ? '' : " as #{name}"}. Add these as GitHub Actions secrets:\n\n"
puts "   STRAVA_CLIENT_ID      #{id}"
puts "   STRAVA_CLIENT_SECRET  #{secret}"
puts "   STRAVA_REFRESH_TOKEN  #{body['refresh_token']}"
puts "\nKeep these private; don't commit them to the repo."
