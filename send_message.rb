#!/usr/bin/env ruby
require 'net/http'
require 'net/smtp'

SEND_TO = 'l.masilevich@gmail.com'

def full_message(subject, msg)
<<MESSAGE_END
From: mlvnotifier <mlvnotifier@gmail.com>
To: #{SEND_TO}
MIME-Version: 1.0
Content-type: text/html
Subject: #{subject}
 
#{msg}
 
MESSAGE_END
end

def send_message(subject, msg)
  smtp = Net::SMTP.new 'smtp.gmail.com', 25
  smtp.enable_starttls
  smtp.start("gmail.com", "mlvnotifier@gmail.com", '5Lipp7BDIk', :login) do |smtp|
    smtp.send_message(full_message(subject, msg), "mlvnotifier@gmail.com", SEND_TO)
  end
end