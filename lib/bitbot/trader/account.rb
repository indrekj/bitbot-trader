require "virtus"

module Bitbot
  module Trader
    # User account info
    #
    class Account
      include Virtus

      attribute :fee, Float
      attribute :wallets, Array[Wallet]

      # Fetches account wallet with given currency
      #
      # @example
      #   account.wallet("USD") #=> <Wallet>
      #
      # @param [String] currency
      #
      # @return [Wallet, nil]
      #
      # @api public
      #
      def wallet(currency)
        wallets.detect { |wallet| wallet.currency == currency }
      end
    end
  end
end
