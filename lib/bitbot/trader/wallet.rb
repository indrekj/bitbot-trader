require "virtus"

module Bitbot
  module Trader
    # User USD/BTC/etc wallet
    #
    class Wallet
      include Virtus.model

      attribute :value, BigDecimal
      attribute :currency, String

      # Builds a new wallet
      #
      # @example
      #   Wallet.build("USD", 1.234)
      #
      # @return [Wallet]
      #
      # @api public
      #
      def self.build(currency, value)
        new(currency: currency, value: value)
      end

      # Shows wallet balance
      #
      # @example
      #   wallet.balance #=> <BigDecimal>
      #
      # @return [BigDecimal]
      #
      # @api public
      #
      alias :balance :value
    end
  end
end
