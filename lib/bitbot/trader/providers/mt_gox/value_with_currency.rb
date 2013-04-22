module Bitbot
  module Trader
    module Providers
      class MtGox
        # Helps managing values with currencies
        #
        class ValueWithCurrency
          # Parses value with currency hash
          #
          # @param [Hash] data
          #
          # @param [Integer] decimal_point
          #   MtGox sends integer values. We use this to divide that value.
          #
          # @return [Hash]
          #
          # @api private
          #
          def self.parse(data, decimal_point)
            value, currency = data.values_at("value_int", "currency")
            {value: BigDecimal(value) / (10 ** decimal_point), currency: currency}
          end
        end
      end
    end
  end
end
