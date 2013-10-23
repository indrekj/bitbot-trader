require "faraday"
require "json"

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
          # @option options [String] :username
          # @option options [String] :password
          #
          # @return [HttpClient]
          #
          # @api private
          #
          def self.build(options)
            username = options.fetch(:username)
            password = options.fetch(:password)

            connection = make_connection
            new(connection, username, password)
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
          attr_reader :username

          # API passsword
          #
          # @return [String]
          #
          # @api private
          #
          attr_reader :password

          # Initializes HttpClient object
          #
          # @param [#post] connection
          # @param [String] username
          # @param [String] password
          #
          # @return [undefined]
          #
          # @api private
          #
          def initialize(connection, username, password)
            @connection = connection
            @username   = username
            @password   = password
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
            options    = options.merge(user: @username, password: @password)
            result     = @connection.post("#{path}/", options).body
            JSON.parse(result)
          end
        end
      end
    end
  end
end
