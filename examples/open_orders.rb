require "bitbot/trader"

bitstamp = Bitbot::Trader::Providers::Bitstamp.new(
  username: ENV["BITSTAMP_USERNAME"],
  password: ENV["BITSTAMP_PASSWORD"]
)

puts "Bitstamp open orders:"
puts bitstamp.open_orders.inspect
