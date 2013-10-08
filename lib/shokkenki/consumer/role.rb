require 'shokkenki/consumer/simplification'

module Shokkenki
  module Consumer
    class Role
      include Shokkenki::Consumer::Simplification

      attr_reader :name

      def initialize arguments
        @name = simplify(arguments[:name])
      end

      def to_hash
        {
          :name => @name
        }
      end

    end
  end
end