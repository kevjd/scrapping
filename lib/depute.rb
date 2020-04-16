require 'rubygems'
require 'nokogiri'
require 'open-uri'

puts "Scrapping en cours........."

# gets First_name
def first_name
  first_name_array = []
  
  url_first_name = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
  url_scrap = Nokogiri::HTML(open(url_first_name))

  first_name_array = url_scrap.xpath("//*[@id='deputes-list']/div/ul/li/a/text()").map {|x| x.to_s }

  return first_name_array
end

#gets link
def link 

  url_depute_array = []

  url_link_depute = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
  url_scrap_depute = Nokogiri::HTML(open(url_link_depute))

  url_depute_array = url_scrap_depute.xpath("//*[@id='deputes-list']/div/ul/li/a/@href").map {|x| x.to_s }
  return url_depute_array
end
link


# gets Email
def email(url_depute_array)

  email_depute_array = []

  for n in 0...url_depute_array.length
    url_email_depute = "http://www2.assemblee-nationale.fr/#{url_depute_array[n]}"

    email_url = Nokogiri::HTML(open(url_email_depute))

    begin
      email_depute_array << email_url.xpath("//*[contains(@class, 'deputes-liste-attributs')]/dd[4]/ul/li[2]/a/text()").to_s
    rescue => e
      email_depute_array << " "
    end
  end
  return email_depute_array
end


# Merge

puts result = Hash[first_name.zip(email(link))]