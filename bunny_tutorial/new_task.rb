require 'bunny'
require 'pry'


conn = Bunny.new

conn.start


ch = conn.create_channel
q = ch.queue("hello", druable: true)

# ch.default_exchange.publish("Hello World!", routing_key: q.name)

msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

q.publish(msg, persistent: true)

puts "[x] Sent #{msg}"

conn.close
