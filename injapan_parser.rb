#!/usr/bin/env ruby
# encoding: utf-8
require 'open-uri'
require 'nokogiri'
require_relative 'common'
require_relative 'send_message'

def parse(options) 

  $redis = init_redis

  html = open(options[:url])
  doc = Nokogiri::HTML(html)
  
  new_elements = Hash.new
  doc.xpath('//div[@id="content"]/div/div/div/div/div/a').each do |node|
    unless $redis.sismember(options[:url],node[:href])
       new_elements["https://injapan.ru#{node[:href]}"] = node[:title]
       $redis.sadd(options[:url], node[:href])
    end
  end

  send_message(subject: "New results for: #{options[:product]}", 
    msg: hash_to_html_list(new_elements), to: options[:send_to]) if new_elements.any?

end

parse(url: 'https://injapan.ru/search/do.html?query=stella+C2000S', product: 'stella c2000s')
parse(url: 'https://injapan.ru/search/do.html?query=stella+1000S', product: 'stella 1000s')
parse(url: 'https://injapan.ru/search/do.html?query=S707SULT', product: 'S707SULT')
parse(url: 'https://injapan.ru/search/do.html?query=dxtc-bcx74', product: 'dxtc-bcx74')
parse(url: 'https://injapan.ru/search/do.html?query=24mm+f%2F2.8D', product: '24mm f/2.8D', send_to: "4udo.v.kedax@gmail.com")
parse(url: 'https://injapan.ru/search/do.html?query=28mm+f%2F2.8D', product: '28mm f/2.8D', send_to: "4udo.v.kedax@gmail.com")
parse(url: 'https://injapan.ru/search/do.html?query=18-200mm+F%2F3.5-6.3+XR+LD', product: '18-200mm F/3.5-6.3 XR LD', send_to: "4udo.v.kedax@gmail.com")
parse(url: 'https://injapan.ru/search/do.html?query=SP+17-50+mm+f%2F2.8+XR+LD', product: 'SP 17-50 mm f/2.8 XR LD', send_to: "4udo.v.kedax@gmail.com")
parse(url: 'https://injapan.ru/search/do.html?query=10-20mm+F4-5.6+EX+DC+HSM', product: 'Sigma 10-20mm F4-5.6 EX DC HSM', send_to: "4udo.v.kedax@gmail.com")
parse(url: 'https://injapan.ru/search/do.html?query=SP+AF10-24mm+F%2F3.5-4.5+LD', product: 'SP AF10-24mm F/3.5-4.5 LD', send_to: "4udo.v.kedax@gmail.com")