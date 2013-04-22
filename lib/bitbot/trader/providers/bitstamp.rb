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
      end
    end
  end
end
