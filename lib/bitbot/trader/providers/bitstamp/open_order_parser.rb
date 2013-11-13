module Bitbot
  module Trader
    module Providers
      class Bitstamp
        # Parses raw open orders
        #
        class OpenOrderParser < Parser
          include Virtus.model

          attribute :id,     Integer
          attribute :price,  BigDecimal
          attribute :amount, BigDecimal
          attribute :type,   Integer

          # Makes raw open order hash into OpenOrder object
          #
          # @return [OpenOrder]
          #
          # @api private
          #
          def parse
            OpenOrder.new(
              id: id,
              price: {value: price, currency: "USD"},
              amount: {value: amount, currency: "BTC"},
              bid: type == 0
            )
          end
        end
      end
    end
  end
end
