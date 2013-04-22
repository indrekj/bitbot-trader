module Bitbot
  module Trader
    module Providers
      class MtGox
        # POST request to /money/info
        #
        # @see https://en.bitcoin.it/wiki/MtGox/API/HTTP/v1
        #
        class AccountInfoRequest < Request
          # Fetches user's account info
          #
          # @return [Account]
          #
          # @api private
          #
          def call
            raw_account = client.post("money/info")["data"]
            AccountInfoParser.new(raw_account).parse
          end
        end
      end
    end
  end
end
