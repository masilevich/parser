#!/usr/bin/env ruby
# encoding: utf-8
require 'net/http'
require 'net/smtp'

DEFAULT_SEND_TO = 'l.masilevich@gmail.com'

def full_message(to, subject, msg)
<<MESSAGE_END
From: <#{ENV['MAIL_LOGIN']}>
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
  smtp.start("gmail.com", ENV['MAIL_LOGIN'], ENV['MAIL_PASSWORD'], :login) do |smtp|
    smtp.send_message(full_message(to, options[:subject], options[:msg]), ENV['MAIL_LOGIN'], to)
  end
end