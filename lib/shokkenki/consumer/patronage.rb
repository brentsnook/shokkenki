require 'shokkenki/consumer/ticket'
require 'shokkenki/consumer/interaction'
require 'shokkenki/consumer/simplification'

module Shokkenki
  module Consumer
    class Patronage
      include Shokkenki::Consumer::Simplification

      attr_reader :name, :consumer, :interactions

      def initialize attributes
        @name = simplify(attributes[:name])
        @consumer = attributes[:consumer]
        @interactions = []
      end

      def add_interaction interaction
        @interactions << interaction
      end

      def ticket
        Ticket.new(
          :consumer => @consumer.name,
          :provider => @name,
          :interactions => @interactions
        )
      end
    end
  end
end