require 'rubygems'
require 'nokogiri'
require 'open-uri'

puts "Scrapping en cours........."

# identify page
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

# scrap data and convert into string
all_names_crypto = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td/div/a/text()').map {|x| x.to_s}
all_values_crypto = page.xpath('//*[@id="__next"]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td/a/text()').map {|x| x.to_s}

# merge values to Hash
result = Hash[all_names_crypto.zip(all_values_crypto)]

puts result


