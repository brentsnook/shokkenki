require 'shokkenki/consumer/patronage'

module Shokkenki
  module Consumer
    class ConsumerRole

      attr_reader :name, :patronages

      def initialize arguments
        @name = arguments[:name]
        @patronages = {}
      end

      def patronage provider_name
        @patronages[provider_name] ||= Shokkenki::Consumer::Patronage.new :name => provider_name, :consumer => self
      end

      def tickets
        @patronages.values.collect &:ticket
      end

    end
  end
end