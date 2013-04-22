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
      end
    end
  end
end
