#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require_relative 'common'
require_relative 'send_message'

def parse(url) 

  $redis = init_redis

  html = open(url)
  doc = Nokogiri::HTML(html)
  
  new_elements = Hash.new
  doc.xpath('//table[@id="itemtable"]/tbody/tr/td/a').each do |node|
    unless $redis.sismember(url,node[:href])
       new_elements["https://injapan.ru#{node[:href]}"] = node.text()
       $redis.sadd(url, node[:href])
    end
  end

  send_message("New results for url: #{url}", 
    hash_to_html_list(new_elements)) if new_elements.any?

end

parse('http://b-net.tackleberry.co.jp/ec/stk/stk_list.cfm?step=type&mode=2&bid=TB0002&ctgry=0001&knd=NONE&mkr=0060&mdl=161c&word=')
parse('http://b-net.tackleberry.co.jp/ec/stk/stk_list.cfm?step=type&mode=2&bid=TB0002&ctgry=0001&knd=NONE&mkr=0060&mdl=1545&word=')