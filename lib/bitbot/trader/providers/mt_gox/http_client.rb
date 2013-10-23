require "faraday"
require "json"

module Bitbot
  module Trader
    module Providers
      class MtGox
        # MtGox specific http client
        #
        class HttpClient
          HOST = "https://data.mtgox.com/api/2/"

          # Builds a new HttpClient object
          #
          # @param [Hash] options
          # @option options [String] :username
          # @option options [String] :password
          #
          # @return [HttpClient]
          #
          # @api private
          #
          def self.build(options)
            key = options.fetch(:key)
            secret = options.fetch(:secret)

            connection = make_connection(key, secret)
            new(connection)
          end

          # Creates a new faraday connection object
          #
          # @param [String] key
          # @param [String] secret
          #
          # @return [Faraday::Connection]
          #
          # @api private
          #
          def self.make_connection(key, secret)
            Faraday.new(url: HOST) do |faraday|
              faraday.request :url_encoded
              faraday.request :hmac, key: key, secret: secret
              faraday.adapter :net_http
            end
          end

          # Return connection
          #
          # @return [Object]
          #
          # @api private
          #
          attr_reader :connection

          # Return nonce generator
          #
          # @return [Object]
          #
          # @api private
          attr_reader :nonce_generator

          # Initializes HttpClient object
          #
          # @param [#post] connection
          # @param [#generate] nonce_generator
          #   must return a uniq number
          #
          # @return [undefined]
          #
          # @api private
          #
          def initialize(connection, nonce_generator = Utils::NonceGenerator)
            @connection = connection
            @nonce_generator = nonce_generator
          end

          # Sends post request to given path
          #
          # @param [String] path
          #   e.g. "money/orders"
          # @param [Hash] options
          #   post request parameters
          #
          # @return [Hash]
          #
          # @api private
          #
          def post(path, options = {})
            options = options.merge(nonce: @nonce_generator.generate)
            result  = @connection.post(path, options).body
            JSON.parse(result)
          end
        end
      end
    end
  end
end
