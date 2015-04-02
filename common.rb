#!/usr/bin/env ruby
# encoding: utf-8
require 'redis'
require 'open-uri'
require 'nokogiri'

def init_redis
	uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

def hash_to_html_list(hash)
  out = "<ul>\n"
  hash.each do |key, value|
    out += "<li><strong>#{value}:</strong>"
    out += " <span>#{key}</span></li>\n"
  end
  out += "</ul>\n"
end

def parse(options) 

  $redis = init_redis

  html = open(URI.encode(options[:url]))
  doc = Nokogiri::HTML(html)
  doc.encoding = 'utf-8'
  
  new_elements = Hash.new
  doc.xpath(options[:xpath]).each do |node|
    unless $redis.sismember(options[:url],node[:href])
       yield(new_elements, node)
       $redis.sadd(options[:url], node[:href])
    end
  end

  send_message(subject: "New results for: #{options[:product]}", 
    msg: hash_to_html_list(new_elements), to: options[:send_to]) if new_elements.any?

end