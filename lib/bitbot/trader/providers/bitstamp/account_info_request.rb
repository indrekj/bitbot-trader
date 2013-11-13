module Bitbot
  module Trader
    module Providers
      class Bitstamp
        # POST request to /balance
        #
        # @see https://www.bitstamp.net/api/
        #
        class AccountInfoRequest < Request
          # Fetches user's account info
          #
          # @return [Account]
          #
          # @api private
          #
          def call
            raw_account = client.post("balance")
            AccountInfoParser.new(raw_account).parse
          end
        end
      end
    end
  end
end
