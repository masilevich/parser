#!/usr/bin/env ruby
# encoding: utf-8
require 'redis'
require 'open-uri'

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