#!/usr/bin/env ruby
require 'net/http'
require 'net/smtp'

SEND_TO = 'l.masilevich@gmail.com'

def ping_api_1
  post_check('http://example.com/resources')
end

def get_check(url) 
  begin
    res = Net::HTTP.get_response(URI(url))
    if res.code == "200"
      puts "alive #{url}"
    else
      send_message("Something wrong with #{url}")
    end
  rescue => e
    send_message("Something wrong with #{url} #{e.inspect}")
  end
end

def full_message(msg)
  <<MESSAGE_END
  From: mlvnotifier <mlvnotifier@gmail.com>
  To: Developers
  MIME-Version: 1.0
  Content-type: text/html
  Subject: #{msg}

  <h2>Error</h2>
  <br/>
  #{msg}<br/>
  <br/>

  MESSAGE_END
end

def send_message(msg)
  smtp = Net::SMTP.new 'smtp.gmail.com', 587
  smtp.enable_starttls
  smtp.start("gmail.com", "mlvnotifier@gmail.com", '5Lipp7BDIk', :login) do |smtp|
    smtp.send_message(full_message(msg), "mlvnotifier@gmail.com", SEND_TO)
  end
end

puts "Start scanning at #{Time.now}"

threads = []
threads << Thread.new { parse('ステラ+C2000S') }
threads << Thread.new { parse('ステラ+1000S') }

threads.each do |t|
  t.join
end
puts "Complete scanning at #{Time.now}"