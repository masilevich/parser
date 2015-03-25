#!/usr/bin/env ruby
require 'net/http'
require 'net/smtp'
require 'open-uri'
require 'nokogiri'
require 'yaml'

SEND_TO = 'l.masilevich@gmail.com'

def parse(query) 

  results_array_file = "#{query}.txt"

  previous_elements =[]

  results_file = File.open(results_array_file, "a+")
  results_file.each_line do |line|
    previous_elements << line.chomp
  end

  url = "https://injapan.ru/search/do.html?query=#{query}"
  html = open(url)
  doc = Nokogiri::HTML(html)
  
  current_elements = []
  doc.xpath('//div[@id="content"]/div/div/div/div/a/@href').each do |node|
    current_elements << "https://injapan.ru#{node.text}"
  end
  current_elements.uniq!

  new_elements = current_elements - previous_elements

  send_message("New results for query: #{query}", y(new_elements)) if new_elements.any?

  new_elements.each { |element| results_file.puts(element) }
  results_file.close

end

def full_message(subject, msg)
<<MESSAGE_END
From: mlvnotifier <mlvnotifier@gmail.com>
To: #{SEND_TO}
MIME-Version: 1.0
Content-type: text/html
Subject: #{subject}
 
<br/>
#{msg}<br/>
<br/>
 
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
parse('stella+1000S')

puts "Complete scanning at #{Time.now}"