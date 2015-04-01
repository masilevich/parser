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
  doc.xpath('//table[@id="itemtable"]/tbody/tr/td/a').each do |node|
    unless $redis.sismember(options[:url],node[:href])
       new_elements[node[:href]] = node.text()
       $redis.sadd(options[:url], node[:href])
    end
  end

  send_message(subject: "New results for: #{options[:product]}", 
    msg: hash_to_html_list(new_elements), to: options[:send_to]) if new_elements.any?

end

parse(product: 'stella c2000s new', url: 'http://b-net.tackleberry.co.jp/ec/stk_new/stk_list.cfm?step=ctgry&select=all&word=10%83X%83e%83%89C2000S&search1.x=7&search1.y=12&search1=%8C%9F%8D%F5')
parse(product: 'S707SULT new', url: 'http://b-net.tackleberry.co.jp/ec/stk_new/stk_list.cfm?step=ctgry&select=all&word=10%83X%83e%83%89C2000S&search1.x=7&search1.y=12&search1=%8C%9F%8D%F5')
parse(product: 'S707SULT used', url: 'http://b-net.tackleberry.co.jp/ec/stk/stk_list.cfm?step=ctgry&select=all&word=s707sult&search1.x=36&search1.y=4&search1=%8C%9F%8D%F5')
parse(product: 'dxtc-bcx74', url: 'http://b-net.tackleberry.co.jp/ec/stk/stk_list.cfm?step=ctgry&select=all&word=bcx74&search1.x=23&search1.y=9&search1=%8C%9F%8D%F5')