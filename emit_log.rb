require 'bunny'

conn = Bunny.new
conn.start

ch  = conn.create_channel
x   = ch.fanout("logs")

msg = ARGV.empty? ? 'Hello World!' : ARGV.join(" ")

x.publish(msg)
puts " [x] sent #{msg}"

conn.close
