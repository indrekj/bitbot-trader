require "bitbot/trader"

bitstamp = Bitbot::Trader::Providers::Bitstamp.new(
  client_id:  ENV["BITSTAMP_CLIENT_ID"],
  api_key:    ENV["BITSTAMP_KEY"],
  api_secret: ENV["BITSTAMP_SECRET"]
)

puts "Bitstamp sell order:"
puts bitstamp.sell(amount: 0.1, price: 1235.3).inspect
