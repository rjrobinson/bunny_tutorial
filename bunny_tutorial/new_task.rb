require 'bunny'
require 'pry'

hi = 'Hello'
conn = Bunny.new

conn.start


ch = conn.create_channel
q = ch.queue("hello")
ch.default_exchange.publish(hi, routing_key: q.name)

msg = ARGV.empty? ? "Hello, World!" : ARGV.join(" ")

10.times do q.publish(msg, persistent: true)
  puts "[x] Sent #{msg}"
end

conn.close
