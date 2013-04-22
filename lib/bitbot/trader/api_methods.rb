module Bitbot
  module Trader
    # API methods that can be used with every provider
    #
    module ApiMethods
      # Fetches user's current open orders
      #
      # @example
      #   provider.open_orders #=> [<OpenOrder>, <OpenOrder>]
      #
      # @return [Array<OpenOrder>]
      #
      # @api public
      #
      def open_orders
        self.class::OpenOrdersRequest.new(@client).call
      end
    end
  end
end
