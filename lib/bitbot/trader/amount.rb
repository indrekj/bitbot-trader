require "virtus"

module Bitbot
  module Trader
    # Amount value object. Every amount has a value and a currency.
    # e.g 5.6 USD
    #
    class Amount
      include Virtus.model

      attribute :value, BigDecimal
      attribute :currency, String
    end
  end
end
