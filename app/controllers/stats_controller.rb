class StatsController < ApplicationController
  def index
    url = URI("https://free-nba.p.rapidapi.com/stats?page=0&per_page=25")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = "#{Rails.application.credentials.nba_api[:api_key]}"
    request["X-RapidAPI-Host"] = "free-nba.p.rapidapi.com"

    response = http.request(request)
    data = JSON.parse(response.body)
    render json: data.as_json
  end
end
