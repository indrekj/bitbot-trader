require "virtus"

module Bitbot
  module Trader
    module Providers
      # Provider for MtGox API (version 2)
      #
      # @see https://en.bitcoin.it/wiki/MtGox/API/HTTP/v2
      #
      class MtGox < Provider
        # Initializes MtGox provider
        #
        # @param [Hash] options
        # @option options [String] :key
        # @option options [String] :secret
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
          AccountInfoParser.parse(post("money/info"))
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
          OpenOrderParser.parse_collection(post("money/orders"))
        end

        private

        def post(path)
          @client.post(path)["data"]
        end
      end
    end
  end
end
