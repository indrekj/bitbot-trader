require "virtus"

module Bitbot
  module Trader
    # Value object for user open order
    #
    class OpenOrder
      include Virtus.model

      attribute :id,     String
      attribute :price,  Price
      attribute :amount, Amount
      attribute :bid,    Boolean

      # Checks if order is a ask order
      #
      # @example
      #   OpenOrder.new(bid: true).ask? #=> false
      #
      # @return [Boolean]
      #
      # @api public
      #
      def ask?
        !bid?
      end
    end
  end
end
