require "virtus"

module Bitbot
  module Trader
    module Providers
      # Provider for Bitstamp API
      #
      # @see https://www.bitstamp.net/api/
      #
      class Bitstamp < Provider
        # Initializes Bitstamp provider
        #
        # @param [Hash] options
        # @option options [String] :username
        # @option options [String] :password
        #
        # @param [HttpClient] client
        #
        # @return [undefined]
        #
        # @api public
        #
        def initialize(options, client = HttpClient.build(options))
          @client = client
        end

        # Fetches user's account info
        #
        # @example
        #   provider.account #=> <Account>
        #
        # @return [Account]
        #
        # @api public
        #
        def account
          AccountInfoParser.parse(post("balance"))
        end

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
          OpenOrderParser.parse_collection(post("open_orders"))
        end

        # Creates a limit bid order
        #
        # @example
        #   provider.buy(amount: 10, price: 298)
        #
        # @return [OpenOrder]
        #
        # @api public
        #
        def buy(amount:, price:)
          OpenOrderParser.parse(post("buy", amount: amount, price: price))
        end

        # Creates a limit ask order
        #
        # @example
        #   provider.sell(amount: 2, price: 1298)
        #
        # @return [OpenOrder]
        #
        # @api public
        #
        def sell(amount:, price:)
          raise NotImplementedError
        end

        private

        def post(path, opts = {})
          @client.post(path, opts)
        end
      end
    end
  end
end
