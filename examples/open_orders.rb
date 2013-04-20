require "bitbot/trader"

bitstamp = Bitbot::Trader::Providers::Bitstamp.new(
  username: ENV["BITSTAMP_USERNAME"],
  password: ENV["BITSTAMP_PASSWORD"]
)

puts "Bitstamp open orders:"
puts bitstamp.open_orders.inspect

mt_gox = Bitbot::Trader::Providers::MtGox.new(
  key: ENV["MTGOX_KEY"],
  secret: ENV["MTGOX_SECRET"]
)
puts "MtGox open orders:"
puts mt_gox.open_orders.inspect
