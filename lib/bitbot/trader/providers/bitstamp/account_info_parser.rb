module Bitbot
  module Trader
    module Providers
      class Bitstamp
        # Parses raw open orders
        #
        class AccountInfoParser < Parser
          include Virtus.model

          attribute :fee, Float
          attribute :btc_balance, Float
          attribute :usd_balance, Float

          # Makes raw account info hash into Account object
          #
          # @return [Account]
          #
          # @api private
          #
          def parse
            Account.new(
              fee: fee,
              wallets: [
                Wallet.build("USD", usd_balance),
                Wallet.build("BTC", btc_balance)
              ]
            )
          end
        end
      end
    end
  end
end
