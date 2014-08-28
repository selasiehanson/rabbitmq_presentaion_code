#!/Users/selasiehanson/.rvm/rubies/ruby-2.1.0/bin/ruby
# encoding utf-8


require 'rubygems'
require 'bunny'


conn = Bunny.new
conn.start

ch = conn.create_channel
queue = ch.queue("task_queue", durable: true)

msg = ARGV.empty? ? 'Hello World' : ARGV.join(' ')
queue.publish(msg, persistent: true)
puts " [x] Sent #{msg}"

sleep 1.0
conn.close
