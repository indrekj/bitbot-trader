module Bitbot
  module Trader
    module Providers
      class MtGox
        # Parses raw open orders
        #
        class AccountInfoParser < Parser
          include Virtus.model

          attribute :Trade_Fee, Float
          attribute :Wallets, Hash

          # Makes raw account info hash into Account object
          #
          # @return [Account]
          #
          # @api private
          #
          def parse
            parsed = attributes

            Account.new(
              fee: parsed[:Trade_Fee],
              wallets: self.class.parse_wallets(parsed[:Wallets])
            )
          end

          # Parses raw wallets
          #
          # @param [Hash<String, Hash>] raw_wallets
          #
          # @return [Array<Hash>]
          #
          # @api private
          #
          def self.parse_wallets(raw_wallets)
            raw_wallets.map { |_key, raw_wallet|
              ValueWithCurrencyCoercer.call(raw_wallet["Balance"])
            }
          end
        end
      end
    end
  end
end
