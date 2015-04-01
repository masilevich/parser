#!/usr/bin/env ruby
require 'net/http'
require 'net/smtp'

DEFAULT_SEND_TO = 'l.masilevich@gmail.com'

def full_message(to, subject, msg)
<<MESSAGE_END
From: mlvnotifier <mlvnotifier@gmail.com>
To: #{to}
MIME-Version: 1.0
Content-type: text/html
Subject: #{subject}
 
#{msg}
 
MESSAGE_END
end

def send_message(options = {})
	to = options[:to] || DEFAULT_SEND_TO
  smtp = Net::SMTP.new 'smtp.gmail.com', 25
  smtp.enable_starttls
  smtp.start("gmail.com", "mlvnotifier@gmail.com", '5Lipp7BDIk', :login) do |smtp|
    smtp.send_message(full_message(to, options[:subject], options[:msg]), "mlvnotifier@gmail.com", to)
  end
end