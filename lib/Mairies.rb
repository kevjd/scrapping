require 'rubygems'
require 'nokogiri'
require 'open-uri'

puts "Scrapping en cours........."

# Fetch city
def get_city
  city_name_array = []
  url_region = "http://www.annuaire-des-mairies.com/ille-et-vilaine.html"
  region_page = Nokogiri::HTML(open(url_region))
  return city_name_array = region_page.xpath("//a[contains(@class, 'lientxt')]/text()").map {|x| x.to_s.downcase.gsub(" ", "-") }
end

#Fetch email
def get_email (city_name_array)

  city_email_array = []

  for n in 0...city_name_array.length
    page_url_city = "http://www.annuaire-des-mairies.com/35/#{city_name_array[n]}.html"

    city_page = Nokogiri::HTML(open(page_url_city))

    begin
      city_email_array << city_page.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").to_s
    rescue => e
      city_email_array << " "
    end
  end
  return city_email_array
end

# Merge
puts result = Hash[get_city.zip(get_email(get_city))]