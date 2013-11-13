module Bitbot
  module Trader
    module Providers
      class MtGox
        # Parses raw open orders
        #
        class OpenOrderParser < Parser
          include Virtus.model

          attribute :oid,              String
          attribute :currency,         String
          attribute :type,             String
          attribute :effective_amount, Amount, coercer: ValueWithCurrencyCoercer
          attribute :price,            Price,  coercer: ValueWithCurrencyCoercer
          attribute :type,             String

          # Makes raw open order hash into OpenOrder object
          #
          # @return [OpenOrder]
          #
          # @api private
          #
          def parse
            OpenOrder.new(
              id: oid,
              price: price,
              amount: effective_amount,
              bid: type == "bid"
            )
          end
        end
      end
    end
  end
end
