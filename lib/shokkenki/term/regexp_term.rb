require_relative 'ruby-string-random/lib/strrand'

module Shokkenki
  module Term
    class RegexpTerm

      attr_reader :value

      def self.from_json json
        new json['value']
      end

      def initialize value
        @value = Regexp.new value
      end

      def example
        StringRandom.random_regex @value.to_s
      end

      def match? compare
        compare && !@value.match(compare.to_s).nil?
      end
    end
  end
end