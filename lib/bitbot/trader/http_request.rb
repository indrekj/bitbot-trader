require "httparty"

module Bitbot
  module Trader
    # HTTP requests helper
    #
    class HttpRequest
      # Makes HTTP POST request
      #
      # @param [String] path
      #
      # @param [Hash] body
      #   post params
      #
      # @return [Hash]
      #   parsed result
      #
      # @api private
      #
      def self.post(path, body)
        HTTParty.post(path, body: body).parsed_response
      end
    end
  end
end
