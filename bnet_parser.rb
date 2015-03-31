#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require_relative 'common'
require_relative 'send_message'

def parse(subject, url) 

  $redis = init_redis

  html = open(url)
  doc = Nokogiri::HTML(html)
  
  new_elements = Hash.new
  doc.xpath('//table[@id="itemtable"]/tbody/tr/td/a').each do |node|
    unless $redis.sismember(url,node[:href])
       new_elements[node[:href]] = node.text()
       $redis.sadd(url, node[:href])
    end
  end

  send_message("New results for url: #{subject}", 
    hash_to_html_list(new_elements)) if new_elements.any?

end

parse('stella c2000s new','http://b-net.tackleberry.co.jp/ec/stk_new/stk_list.cfm?step=ctgry&select=all&word=10%83X%83e%83%89C2000S&search1.x=7&search1.y=12&search1=%8C%9F%8D%F5')
parse('S707SULT new', 'http://b-net.tackleberry.co.jp/ec/stk_new/stk_list.cfm?step=ctgry&select=all&word=10%83X%83e%83%89C2000S&search1.x=7&search1.y=12&search1=%8C%9F%8D%F5')
parse('S707SULT used', 'http://b-net.tackleberry.co.jp/ec/stk/stk_list.cfm?step=ctgry&select=all&word=s707sult&search1.x=36&search1.y=4&search1=%8C%9F%8D%F5')