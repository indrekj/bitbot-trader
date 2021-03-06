module Bitbot
  module Trader
    # Request class for different api methods
    #
    # @abstract
    #
    class Request
      # Object that communicates with external API
      #
      # @return [Object]
      #
      # @api private
      #
      attr_reader :client

      # Initializes request object
      #
      # @param [Object] client
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(client)
        @client = client
      end

      # Every request object implements call
      #
      # @abstract
      #
      # @return [undefined]
      #
      # @api private
      #
      def call(*)
        raise NotImplementedError
      end
    end
  end
end
