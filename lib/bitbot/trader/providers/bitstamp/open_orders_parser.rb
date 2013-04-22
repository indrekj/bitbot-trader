module Bitbot
  module Trader
    module Providers
      class Bitstamp
        # Parses raw open orders
        #
        class OpenOrderParser
          include Virtus

          attribute :id,     Integer
          attribute :price,  BigDecimal
          attribute :amount, BigDecimal

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
              amount: amount
            )
          end
        end
      end
    end
  end
end
