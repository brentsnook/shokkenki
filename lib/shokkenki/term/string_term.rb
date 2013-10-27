module Shokkenki
  module Term
    class StringTerm

      attr_reader :value

      def self.from_json json
        new json['value']
      end

      def initialize value
        @value = value
      end

      def example
        @value
      end

      def match? compare
        compare && (compare.strip == @value)
      end
    end
  end
end