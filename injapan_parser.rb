#!/usr/bin/env ruby
require_relative 'common'

def parse_injapan(options)
  options[:xpath] = '//div[@id="content"]/div/div/div/div/div/a'
  parse(options) do |new_elements, node|
    new_elements["https://injapan.ru#{node[:href]}"] = node[:title]
  end
end

parse_injapan(url: 'https://injapan.ru/search/do.html?query=S707SULT', product: 'S707SULT')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=PSSS-84T', product: 'Ever Green Salty Sensation PSSS-84T', send_to: 'banibaks89@mail.ru')