require "bitbot/trader"

bitstamp = Bitbot::Trader::Providers::Bitstamp.new(
  client_id:  ENV["BITSTAMP_CLIENT_ID"],
  api_key:    ENV["BITSTAMP_KEY"],
  api_secret: ENV["BITSTAMP_SECRET"]
)

puts "Bitstamp open orders:"
puts bitstamp.open_orders.inspect

mt_gox = Bitbot::Trader::Providers::MtGox.new(
  key: ENV["MTGOX_KEY"],
  secret: ENV["MTGOX_SECRET"]
)
puts "MtGox open orders:"
puts mt_gox.open_orders.inspect
