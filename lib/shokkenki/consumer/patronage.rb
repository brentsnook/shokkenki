require 'shokkenki/consumer/ticket'
require 'shokkenki/consumer/interaction'
require 'shokkenki/consumer/simplification'

module Shokkenki
  module Consumer
    class Patronage
      include Shokkenki::Consumer::Simplification

      attr_reader :name, :consumer

      def initialize attributes
        @name = simplify(attributes[:name])
        @consumer = attributes[:consumer]
        @interactions = []
      end

      def during interaction_label
        interaction = Interaction.new(:label => interaction_label)
        @interactions << interaction
        interaction
      end

      def ticket
        Ticket.new :consumer => @consumer.name, :provider => @name
      end
    end
  end
end