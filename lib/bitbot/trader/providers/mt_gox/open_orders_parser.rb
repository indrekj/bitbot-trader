module Bitbot
  module Trader
    module Providers
      class MtGox
        # Parses raw open orders
        #
        class OpenOrderParser
          include Virtus

          attribute :oid,              String
          attribute :currency,         String
          attribute :type,             String
          attribute :effective_amount, Hash
          attribute :price,            Price, writer_class: PriceWriter

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
              amount: BigDecimal(effective_amount["value_int"]) / 1_0000_0000
            )
          end
        end
      end
    end
  end
end
