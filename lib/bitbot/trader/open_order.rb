require "virtus"

module Bitbot
  module Trader
    # Value object for user open order
    #
    class OpenOrder
      include Virtus

      attribute :id,     String
      attribute :price,  Price
      attribute :amount, Amount
      attribute :bid,    Boolean
    end
  end
end
