require 'bunny'

conn = Bunny.new

conn.start

ch       = conn.create_channel
x        = ch.topic("topic_logs")
severity = ARGV.shift || "anonymous.info"
msg      = ARGV.empty? ? "Hellp World" : ARGV.join(" ")

x.publish(msg, routing_key: severity)
p " [x] Sent #{severity}:#{msg}"

conn.close
