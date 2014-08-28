#!/Users/selasiehanson/.rvm/rubies/ruby-2.1.0/bin/ruby
# encoding utf-8


require 'rubygems'
require 'bunny'


conn = Bunny.new
conn.start

ch = conn.create_channel
queue = ch.queue("hello")
exchange = ch.default_exchange
exchange.publish("Hello world", routing_key: queue.name)
conn.close
