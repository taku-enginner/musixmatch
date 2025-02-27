require "json"
require "net/http"
require "uri"

class MusixmatchController < ApplicationController
  def index
    access_key = ENV["MUSIXMATCH_API_KEY"]
    Rails.logger.info("access_key: #{access_key}")
  
    endpoint = "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get"
    
    data = {
      "q_artist" => "ARASHI",  # 大文字・正式名称に修正
      "q_track" => "Love So Sweet",
      "apikey" => access_key
    }
  
    uri = URI(endpoint)
    uri.query = URI.encode_www_form(data)
  
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(uri)
    res = http.request(req)
  
    Rails.logger.info("Musixmatch API response code: #{res.code}")
    Rails.logger.info("Musixmatch API response body: #{res.body}")
    p "Musixmatch API response code: #{res.code}"
    p "Musixmatch API response body: #{res.body}"

  
    if res.is_a?(Net::HTTPSuccess)
      response = JSON.parse(res.body)
      Rails.logger.info("Parsed response: #{response}")
    else
      Rails.logger.error("Failed to fetch lyrics: #{res.code} - #{res.body}")
    end
  end
  

  private

  def musixmatch_params
    params.require(:musixmatch).permit(:artist, :song_title)
  end
end
