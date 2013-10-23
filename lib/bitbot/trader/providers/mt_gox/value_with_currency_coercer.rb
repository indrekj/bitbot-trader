module Bitbot
  module Trader
    module Providers
      class MtGox
        # Helps managing values with currencies
        #
        class ValueWithCurrencyCoercer < Virtus::Attribute
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
          def self.call(data)
            value, currency = data.values_at("value_int", "currency")
            decimal_point = currency == "BTC" ? 8 : 5
            {value: BigDecimal(value) / (10 ** decimal_point), currency: currency}
          end
        end
      end
    end
  end
end
