class SiteScraper
  def initialize(link)
    @link = link
  end

  def scraper
    html = URI.open(@link)
    doc = Nokogiri::HTML(html)
    title = doc.css(".content-title").text.strip
    original_comments = doc.css(".comment__text").text.split(" \n ").collect(&:strip).find_all{|e| e.length > 0}[0..50]
    translated_comments = translate(original_comments.join(" ^^^ ").gsub(/[\n"]/,"").scan(/.{1,3200}/)).split("^^^")
    {title: title, original_comments: original_comments, translated_comments: translated_comments}
  end

  def translate(text)
    res = ""
    url = URI("https://deep-translate1.p.rapidapi.com/language/translate/v2")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = "application/json"
    request["X-RapidAPI-Key"] = ENV["RAPIDAPI_KEY"]
    request["X-RapidAPI-Host"] = "deep-translate1.p.rapidapi.com"
    text.each do |part|
      request.body = "{
          #{"q".dump}: \"#{part}\",
          \"source\": \"ru\",
          \"target\": \"en\"
      }"

      response = http.request(request)
      res += JSON.parse(response.read_body)["data"]["translations"]["translatedText"]
    end
    res
  end
end
