require "virtus"

module Bitbot
  module Trader
    # Value object for user open order
    #
    class OpenOrder
      include Virtus::ValueObject

      attribute :id,     String
      attribute :price,  Price
      attribute :amount, BigDecimal
    end
  end
end
