require 'bunny'

if ARGV.empty?
  abort "Usage #{$0} [info] [warning] [error]"
end

connection = Bunny.new
connection.start

channel = connection.create_channel

exchange = channel.direct("direct_logs")

queue = channel.queue("", exclusive: true)

ARGV.each do |severity|
  queue.bind(exchange, routing_key: severity)
end

puts " [*] Waiting for logs. Press CTRL+C to exit"

begin
  queue.subscribe(block: true) do|delivery_info, properties, body|
    puts " [x] #{delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  channel.close
  connection.close
end
