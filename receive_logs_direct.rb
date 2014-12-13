require 'bunny'

if ARGV.empty?
  abort "Usage: #{$0} [info] [warning] [error]"
end

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.direct('direct_logs')
q = ch.queue("", exclusive: true)

ARGV.each do | severity |
  q.bind(x, routing_key: severity)
end

puts " [x] Waiting for logs. to exit press CTRL+C"

begin
  q.subscribe(block: true) do |delivery_info, properties, body|
    p " [x] #{delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end
