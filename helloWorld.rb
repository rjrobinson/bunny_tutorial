require 'bunny'


# a test using the Bunny gem to connect to a RabbitMQ server


conn = Bunny.new

conn.start

ch = conn.create_channel
q = ch.queue("bunny.examples.hello_world", auto_delete: true)
x = ch.default_exchange

q.subscribe do |delivery_info, metadata, payload|
  puts "Received #{payload}"
end

x.publish(": Hello, World!", routing_key: q.name)

sleep 1.0
conn.close
