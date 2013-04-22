module Bitbot
  module Trader
    # Common Provider methods
    #
    # @abstract
    #
    class Provider
      include ApiMethods

      # Object that communicates with external API
      #
      # @return [Object]
      #
      # @api private
      #
      attr_reader :client
    end
  end
end
