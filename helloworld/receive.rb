#!/Users/selasiehanson/.rvm/rubies/ruby-2.1.0/bin/ruby
# encoding utf-8


require 'rubygems'
require 'bunny'


conn = Bunny.new
conn.start

ch = conn.create_channel

queue = ch.queue("hello")

puts " [*] Waiting for messages in #{queue.name}. To exit press CTRL+C"
queue.subscribe do |delivery_info, metadata, payload|
  puts "Received #{payload}"
  delivery_info.consumer.cancel
end

