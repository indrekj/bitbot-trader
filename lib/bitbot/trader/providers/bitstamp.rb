require "virtus"

module Bitbot
  module Trader
    module Providers
      # Provider for Bitstamp API
      #
      # @see https://www.bitstamp.net/api/
      #
      class Bitstamp
        # Bistamp user ID
        #
        # @return [String]
        #
        # @api private
        #
        attr_reader :username

        # Bistamp user password
        #
        # @return [String]
        #
        # @api private
        #
        attr_reader :password

        # Initializes Bitstamp provider
        #
        # @return [undefined]
        #
        # @api private
        #
        def initialize(options)
          @username = options.fetch(:username)
          @password = options.fetch(:password)
        end

        # Fetches user current open orders
        #
        # @example
        #   provider.open_orders #=> [<OpenOrder>, <OpenOrder>]
        #
        # @return [Array<OpenOrder>]
        #
        # @api public
        #
        def open_orders
          OpenOrdersRequest.new(self).call
        end

        # Requests to private API
        #
        # This is used when we need to make requests that need username
        # and password.
        #
        # @abstract
        #
        class AuthenticatedRequest
          HOST = "https://www.bitstamp.net/api"

          class << self
            # Bitstamp API request suffix
            #
            # @return [String]
            #
            # @api private
            #
            attr_accessor :path
          end

          # Initializes authenticated request
          #
          # @return [undefined]
          #
          # @api private
          #
          def initialize(provider, client = HttpRequest)
            @provider = provider
            @client   = client
          end

          private

          # Sends POST request to bistamp
          #
          # @return [Hash]
          #
          # @api private
          #
          def make_request
            @client.post(
              HOST + self.class.path,
              user: @provider.username, password: @provider.password
            )
          end
        end

        # POST request to /open_orders/
        #
        # @see https://www.bitstamp.net/api/
        #
        # TODO: this class does too much. Check specs
        #
        class OpenOrdersRequest < AuthenticatedRequest
          @path = "/open_orders/"

          # Fetches user's open orders
          #
          # @return [Array<OpenOrder>]
          #
          # @api private
          #
          def call
            make_request.map { |raw_order|
              OpenOrderParser.new(raw_order).parse
            }
          end
        end

        # Parses raw open orders
        #
        class OpenOrderParser
          include Virtus::ValueObject

          attribute :id,     Integer
          attribute :price,  BigDecimal
          attribute :amount, BigDecimal

          # Makes raw open order hash into OpenOrder object
          #
          # @return [OpenOrder]
          #
          # @api private
          #
          def parse
            OpenOrder.new(
              id: id,
              price: {value: price, currency: "USD"},
              amount: amount
            )
          end
        end
      end
    end
  end
end
