#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'common'

def parse_bnet(options)
  options[:xpath] = '//table[@id="itemtable"]/tbody/tr/td/a'
  parse(options) do |new_elements, node|
    new_elements[node[:href]] = node.text()
  end
end

parse_bnet(product: 'stella c2000s new', url: 'http://b-net.tackleberry.co.jp/ec/stk_new/stk_list.cfm?step=ctgry&select=all&word=10%83X%83e%83%89C2000S&search1.x=7&search1.y=12&search1=%8C%9F%8D%F5')
parse_bnet(product: 'S707SULT new', url: 'http://b-net.tackleberry.co.jp/ec/stk_new/stk_list.cfm?step=ctgry&select=all&word=10%83X%83e%83%89C2000S&search1.x=7&search1.y=12&search1=%8C%9F%8D%F5')
parse_bnet(product: 'S707SULT used', url: 'http://b-net.tackleberry.co.jp/ec/stk/stk_list.cfm?step=ctgry&select=all&word=s707sult&search1.x=36&search1.y=4&search1=%8C%9F%8D%F5')