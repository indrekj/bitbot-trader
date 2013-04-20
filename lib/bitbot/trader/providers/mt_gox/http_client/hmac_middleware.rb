require "faraday"
require "base64"
require "digest/sha2"
require "digest/hmac"

module Bitbot
  module Trader
    module Providers
      class MtGox
        class HttpClient
          # Signs request with hmac signature
          #
          class HmacMiddleware < Faraday::Middleware
            # Extracts headers, path and body
            #
            # @param [#[]] env
            #   must respond to request_headers, url and body
            #
            # @return [Array]
            #
            # @api private
            #
            def self.extract_params(env)
              headers = env[:request_headers]
              path = env[:url].to_s.split("/2/").last
              body = env[:body]

              [headers, path, body]
            end

            # API key
            #
            # @return [String]
            #
            # @api private
            #
            attr_reader :key

            # API secret
            #
            # @return [String]
            #
            # @api private
            #
            attr_reader :secret

            # Initializes HmacMiddleware
            #
            # @param [Object] app
            # @param [Hash] options
            #
            # @return [undefined]
            #
            # @api private
            #
            def initialize(app, options)
              super(app)
              @key    = options.fetch(:key)
              @secret = options.fetch(:secret)
            end

            # Adds signature to current request
            #
            # @param [Object] env
            #
            # @return [Object]
            #
            # @api private
            #
            def call(env)
              headers, path, body = self.class.extract_params(env)
              prepare_headers(headers, path, body)
              @app.call(env)
            end

            private

            # Adds signature to headers
            #
            # @param [Hash] headers
            # @param [String] path
            # @param [String] body
            #
            # @return [undefined]
            #
            # @api private
            #
            def prepare_headers(headers, path, body)
              headers.merge!(
                "Rest-Key"   => @key,
                "Rest-Sign"  => generate_signature(path, body),
                "User-Agent" => "bitbot-trader"
              )
            end

            # Generates signature
            #
            # @param [String] path
            # @param [String] body
            #
            # @return [String] singature
            #
            # @api private
            #
            def generate_signature(path, body)
              secret = Base64.strict_decode64(@secret)
              data = path + 0.chr + body
              hmac = Digest::HMAC.digest(data, secret, Digest::SHA512)
              Base64.strict_encode64(hmac)
            end
          end

          Faraday::Request.register_middleware hmac: HmacMiddleware
        end
      end
    end
  end
end
