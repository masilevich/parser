#!/usr/bin/env ruby
require 'net/http'
require 'net/smtp'
require 'open-uri'
require 'nokogiri'
require 'redis'

SEND_TO = 'l.masilevich@gmail.com'

def parse(query) 

  uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

  url = "https://injapan.ru/search/do.html?query=#{query}"
  html = open(url)
  doc = Nokogiri::HTML(html)
  
  new_elements = Hash.new
  doc.xpath('//div[@id="content"]/div/div/div/div/div/a').each do |node|
    unless $redis.ismember(query,node[:href])
       new_elements[node[:href]] = node[:title]
       $redis.sadd(query, node[:href])
    end
  end

  send_message("New results for query: #{query}", 
    hash_to_html_list(new_elements)) if new_elements.any?

end

def hash_to_html_list(hash)
  out = "<ul>\n"
  hash.each do |key, value|
    out += "<li><strong>#{value}:</strong>"
    out += " <span>https://injapan.ru#{key}</span></li>\n"
  end
  out += "</ul>\n"
end

def full_message(subject, msg)
<<MESSAGE_END
From: mlvnotifier <mlvnotifier@gmail.com>
To: #{SEND_TO}
MIME-Version: 1.0
Content-type: text/html
Subject: #{subject}
 
#{msg}
 
MESSAGE_END
end

def send_message(subject, msg)
  smtp = Net::SMTP.new 'smtp.gmail.com', 25
  smtp.enable_starttls
  smtp.start("gmail.com", "mlvnotifier@gmail.com", '5Lipp7BDIk', :login) do |smtp|
    smtp.send_message(full_message(subject, msg), "mlvnotifier@gmail.com", SEND_TO)
  end
end

puts "Start scanning at #{Time.now}"

parse('stella+C2000S')
#parse('stella+1000S')

puts "Complete scanning at #{Time.now}"