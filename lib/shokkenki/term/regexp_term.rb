require_relative 'ruby-string-random/lib/strrand'

module Shokkenki
  module Term
    class RegexpTerm

      attr_reader :type, :value

      def self.from_json json
        new json['value']
      end

      def initialize value
        @value = Regexp.new value
        @type = :regexp
      end

      def to_hash
        {
          :type => @type,
          :value => @value.to_s
        }
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