module Bitbot
  module Trader
    # Adds few utility methods for parsers
    #
    class Parser
      def self.parse(item)
        new(item).parse
      end

      def self.parse_collection(items)
        items.map(&method(:parse))
      end
    end
  end
end
