require "bitbot/trader"

bitstamp = Bitbot::Trader::Providers::Bitstamp.new(
  username: ENV["BITSTAMP_USERNAME"],
  password: ENV["BITSTAMP_PASSWORD"]
)

puts "Bitstamp account:"
puts bitstamp.account.inspect

mt_gox = Bitbot::Trader::Providers::MtGox.new(
  key: ENV["MTGOX_KEY"],
  secret: ENV["MTGOX_SECRET"]
)
puts "MtGox account:"
puts mt_gox.account.inspect
