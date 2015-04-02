#!/usr/bin/env ruby
require_relative 'common'

def parse_injapan(options)
  options[:xpath] = '//div[@id="content"]/div/div/div/div/div/a'
  parse(options) do |new_elements, node|
    new_elements["https://injapan.ru#{node[:href]}"] = node[:title]
  end
end

parse_injapan(url: 'https://injapan.ru/search/do.html?query=ステラ+C2000S', product: 'stella c2000s')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=ステラ+1000S', product: 'stella 1000s')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=S707SULT', product: 'S707SULT')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=dxtc-bcx74', product: 'dxtc-bcx74')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=24mm+f%2F2.8D', product: '24mm f/2.8D', send_to: "4udo.v.kedax@gmail.com")
parse_injapan(url: 'https://injapan.ru/search/do.html?query=28mm+f%2F2.8D', product: '28mm f/2.8D', send_to: "4udo.v.kedax@gmail.com")
parse_injapan(url: 'https://injapan.ru/search/do.html?query=18-200mm+F%2F3.5-6.3+XR+LD', product: '18-200mm F/3.5-6.3 XR LD', send_to: "4udo.v.kedax@gmail.com")
parse_injapan(url: 'https://injapan.ru/search/do.html?query=SP+17-50+mm+f%2F2.8+XR+LD', product: 'SP 17-50 mm f/2.8 XR LD', send_to: "4udo.v.kedax@gmail.com")
parse_injapan(url: 'https://injapan.ru/search/do.html?query=10-20mm+F4-5.6+EX+DC+HSM', product: 'Sigma 10-20mm F4-5.6 EX DC HSM', send_to: "4udo.v.kedax@gmail.com")
parse_injapan(url: 'https://injapan.ru/search/do.html?query=SP+AF10-24mm+F%2F3.5-4.5+LD', product: 'SP AF10-24mm F/3.5-4.5 LD', send_to: "4udo.v.kedax@gmail.com")