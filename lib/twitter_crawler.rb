require "net/http"
require "nokogiri"

module TwitterCrawler

  def self.get_crawled_body(from_url, format = 'text')

    result = self.get_http_response(from_url)

    response = result["response"]
    to_url = result["url"]

    doc = Nokogiri::HTML(response.body)
    host = URI.parse(to_url).host

    case host
    when "yfrog.com" 
         image = doc.xpath("//meta[@property='og:image']").first['content']
         format=='text' ? self.get_image2text(image) : self.get_image2html(image)
    when "instagr.am"
         image = doc.xpath("//img[@class='photo']").first['src']
         format=='text' ? self.get_image2text(image): self.get_image2html(image)
    #when Twitvid Twitpic MobyPicture Lockerz <- others services to analize
    else
        format=='text' ? self.get_html2text(to_url) : self.get_html2html(to_url)
    end
  end
  
  def self.get_image2text(image)
    result = self.get_http_response("http://skeeter.blakesmith.me/?image_url=#{URI.escape(image)}&width=80") 
    puts "\nImage URL:\n#{image}\n"
    result["response"].body
  end

  def self.get_image2html(image)
    "<img src='#{URI.escape(image)}'>" 
  end

  def self.get_html2text(url)
    result = self.get_http_response("http://html2text.theinfo.org/?url=#{URI.escape(url)}")
    puts "\nHTML URL:\n#{url}\n"
    return result["response"].body if result["response"].body.strip.length > 0
    self.get_http_response(url)["response"].body
  end

  def self.get_html2html(url)
    "<iframe src='#' onload='this.src=\"#{URI.escape(url)}\"' width='90%' height='400' scrolling='auto' frameborder='1'></iframe>" 
  end

  def self.get_http_response(url)
    puts "url:",url
    begin
      found = false 
      until found
        response = Net::HTTP.get_response(URI.parse(URI.encode(url.strip))) 
        puts response.header['location'] if response.header['location']
        response.header['location'] ? newurl = URI.parse(URI.encode(response.header['location'])): found = true 
        if url != newurl
          if newurl.relative?
            puts "url is relative!!"
            newurl = URI.join(url, newurl.to_s)
            puts "fixed url relative:#{newurl}"
          end
          url = newurl.to_s
        end 
      end 
    rescue Exception => ex
      result = "Unknow error:#{ex.message}"
    end
    puts "final url:", url
    {"url" => url, "response" => response}
  end

end
