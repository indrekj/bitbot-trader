require "bitbot/trader"

bitstamp = Bitbot::Trader::Providers::Bitstamp.new(
  client_id:  ENV["BITSTAMP_CLIENT_ID"],
  api_key:    ENV["BITSTAMP_KEY"],
  api_secret: ENV["BITSTAMP_SECRET"]
)

puts "Bitstamp account:"
puts bitstamp.account.inspect

mt_gox = Bitbot::Trader::Providers::MtGox.new(
  key: ENV["MTGOX_KEY"],
  secret: ENV["MTGOX_SECRET"]
)
puts "MtGox account:"
puts mt_gox.account.inspect
