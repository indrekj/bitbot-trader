module Bitbot
  module Trader
    module Providers
      class MtGox
        # POST request to /money/orders
        #
        # @see https://en.bitcoin.it/wiki/MtGox/API/HTTP/v1
        #
        class OpenOrdersRequest < Request
          # Fetches user's open orders
          #
          # @return [Array<OpenOrder>]
          #
          # @api private
          #
          def call
            client.post("money/orders")["data"].map { |raw_order|
              OpenOrderParser.new(raw_order).parse
            }
          end
        end
      end
    end
  end
end
