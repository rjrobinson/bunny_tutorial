require 'bunny'
require 'pry'


#host = 'rabbitmq-1.45c4208d-bmoyles0117.node.tutum.io'
hi = "Hello world!"
conn = Bunny.new #(hostname: host)

conn.start


ch = conn.create_channel
q = ch.queue("hello")
ch.default_exchange.publish( hi, routing_key: q.name)

puts " [x] Sent #{hi}"

conn.close
