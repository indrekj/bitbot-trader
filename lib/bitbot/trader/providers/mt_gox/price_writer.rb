module Bitbot
  module Trader
    module Providers
      class MtGox
        # Coerces price objects
        #
        class PriceWriter < Virtus::Attribute::Writer::Coercible
          # Takes a hash and makes it compatible with Price attributes
          #
          # @return [Hash]
          #
          # @api private
          #
          def coerce(hash)
            self.class.parse(hash)
          end

          # Parses price or volume
          #
          # @return [Hash]
          #
          # @api private
          #
          def self.parse(hash)
            value, currency = hash.values_at("value_int", "currency")
            {value: BigDecimal(value) / 1_000_00, currency: currency}
          end
        end
      end
    end
  end
end
