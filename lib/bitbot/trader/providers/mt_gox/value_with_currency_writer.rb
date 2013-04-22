require "virtus"

module Bitbot
  module Trader
    module Providers
      class MtGox
        # Coerces data that has value and currency
        #
        class ValueWithCurrencyWriter < Virtus::Attribute::Writer::Coercible
          # Parses data with value and currency
          #
          # @param [Hash] data
          #
          # @return [Hash]
          #
          # @api private
          #
          def coerce(data)
            ValueWithCurrency.parse(data)
          end
        end
      end
    end
  end
end
