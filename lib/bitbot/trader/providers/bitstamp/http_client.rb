require "faraday"
require "json"
require "digest/hmac"

module Bitbot
  module Trader
    module Providers
      class Bitstamp
        # Bitstamp specific http client
        #
        class HttpClient
          HOST = "https://www.bitstamp.net/api/"

          # Build a new HttpClient object
          #
          # @param [Hash] options
          #   @see [#initialize]
          #
          # @return [HttpClient]
          #
          # @api private
          #
          def self.build(options)
            connection = make_connection
            new(connection, options)
          end

          # Creates a new faraday connection object
          #
          # @return [Faraday]
          #
          # @api private
          #
          def self.make_connection
            Faraday.new(url: HOST)
          end

          # Return connection
          #
          # @return [Object]
          #
          # @api private
          #
          attr_reader :connection

          # API username
          #
          # @return [String]
          #
          # @api private
          #
          attr_reader :client_id

          # API key
          #
          # @return [String]
          #
          # @api private
          #
          attr_reader :api_key

          # API secret
          #
          # @return [String]
          #
          # @api private
          #
          attr_reader :api_secret

          # Initializes HttpClient object
          #
          # @param [#post] connection
          #
          # @return [undefined]
          #
          # @api private
          #
          def initialize(connection, client_id:, api_key:, api_secret:)
            @connection = connection
            @client_id  = client_id
            @api_key    = api_key
            @api_secret = api_secret
          end

          # Sends post request to given path
          #
          # @param [String] path
          #   e.g. "open_orders"
          # @param [Hash] options
          #   post request parameters
          #
          # @return [Hash]
          #
          # @api private
          #
          def post(path, options = {})
            nonce, signature = generate_signature
            options = options.merge(key: @api_key, nonce: nonce, signature: signature)
            result  = @connection.post("#{path}/", options).body
            JSON.parse(result)
          end

          private

          def generate_signature
            nonce = Utils::NonceGenerator.generate
            signature = Digest::HMAC.hexdigest(
              "#{nonce}#{@client_id}#{@api_key}", @api_secret, Digest::SHA256
            ).upcase
            [nonce, signature]
          end
        end
      end
    end
  end
end
