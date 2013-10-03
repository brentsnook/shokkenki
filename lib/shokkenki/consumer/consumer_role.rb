require 'shokkenki/consumer/patronage'
require 'shokkenki/consumer/simplification'

module Shokkenki
  module Consumer
    class ConsumerRole
      include Shokkenki::Consumer::Simplification

      attr_reader :name, :patronages

      def initialize arguments
        @name = simplify(arguments[:name])
        @patronages = {}
      end

      def patronage provider_name
        @patronages[simplify(provider_name)] ||= Shokkenki::Consumer::Patronage.new :name => provider_name, :consumer => self
      end

      def tickets
        @patronages.values.collect &:ticket
      end

    end
  end
end