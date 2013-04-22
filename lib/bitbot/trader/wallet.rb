require "virtus"

module Bitbot
  module Trader
    # User USD/BTC/etc wallet
    #
    class Wallet
      include Virtus

      attribute :value, BigDecimal
      attribute :currency, String

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
