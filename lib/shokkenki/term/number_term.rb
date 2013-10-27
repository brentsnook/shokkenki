module Shokkenki
  module Term
    class NumberTerm

      attr_reader :type, :value

      def self.from_json json
        new json['value']
      end

      def initialize value
        @value = value
        @type = :number
      end

      def to_hash
        {
          :type => @type,
          :value => @value
        }
      end

      def example
        @value
      end

      def match? compare
        compare && (compare == @value)
      end
    end
  end
end