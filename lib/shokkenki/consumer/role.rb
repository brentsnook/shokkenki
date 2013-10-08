require 'shokkenki/consumer/simplification'
require 'active_support/core_ext/string/inflections'

module Shokkenki
  module Consumer
    class Role
      include Shokkenki::Consumer::Simplification

      attr_reader :name, :label

      def initialize arguments
        @name = simplify(arguments[:name])
        @label = arguments[:label] || @name.to_s.titleize
      end

      def to_hash
        {
          :name => @name,
          :label => @label
        }
      end

    end
  end
end