require 'bunny'
require 'pry'

# TelTech Provided variables
user = 'admin'
pass = '1Le6VZsVsSpY'
host = 'rabbitmq-1.45c4208d-bmoyles0117.node.tutum.io'
port = 5672

conn = Bunny.new(
  host:     host,
  user:     user,
  password: pass,
  port:     port
  )

conn.start

ch  = conn.create_channel
q   =  ch.queue("rjrobinson")

q.bind("amq.topic")


puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"


q.subscribe(:block => true) do |delivery_info, properties, body|
  puts " [x] Received #{body}"

  # cancel the consumer to exit
  delivery_info.consumer.cancel
end
