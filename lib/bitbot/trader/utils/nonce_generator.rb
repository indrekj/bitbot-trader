module Bitbot
  module Trader
    module Utils
      # Generates a nonce
      #
      # Some http requests use it to prevent double http requests
      #
      class NonceGenerator
        # Generates a nonce from current time
        #
        # @return [Fixnum] nonce
        #
        # @api private
        #
        def self.generate(time_class = Time)
          time_class.now.to_i
        end
      end
    end
  end
end
