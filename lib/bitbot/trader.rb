require "bitbot/trader/version"

module Bitbot
  module Trader
  end
end

require "bitbot/trader/amount"
require "bitbot/trader/price"
require "bitbot/trader/wallet"
require "bitbot/trader/account"
require "bitbot/trader/open_order"
require "bitbot/trader/parser"

require "bitbot/trader/request"
require "bitbot/trader/provider"

require "bitbot/trader/utils/nonce_generator"

require "bitbot/trader/providers/bitstamp"
require "bitbot/trader/providers/bitstamp/http_client"
require "bitbot/trader/providers/bitstamp/open_order_parser"
require "bitbot/trader/providers/bitstamp/account_info_parser"

require "bitbot/trader/providers/mt_gox"
require "bitbot/trader/providers/mt_gox/http_client"
require "bitbot/trader/providers/mt_gox/http_client/hmac_middleware"
require "bitbot/trader/providers/mt_gox/value_with_currency_coercer"
require "bitbot/trader/providers/mt_gox/open_order_parser"
require "bitbot/trader/providers/mt_gox/account_info_parser"
