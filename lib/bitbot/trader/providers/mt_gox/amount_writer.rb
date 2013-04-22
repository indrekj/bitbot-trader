require "virtus"

module Bitbot
  module Trader
    module Providers
      class MtGox
        # Coerces amount objects
        #
        class AmountWriter < Virtus::Attribute::Writer::Coercible
          # Parses amount
          #
          # @param [Hash] data
          #
          # @return [Hash]
          #
          # @api private
          #
          def coerce(data)
            ValueWithCurrency.parse(data, 8)
          end
        end
      end
    end
  end
end
