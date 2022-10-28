module ApiRequest
  def self.call(api_path, api_host)
    url = URI(api_path)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = "application/json"
    request["X-RapidAPI-Key"] = ENV["RAPIDAPI_KEY"]
    request["X-RapidAPI-Host"] = api_host
    {request: request, http: http}
  end
end
