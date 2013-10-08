require 'shokkenki/consumer/ticket'
require 'shokkenki/consumer/interaction'

module Shokkenki
  module Consumer
    class Patronage

      attr_reader :provider, :consumer, :interactions

      def initialize attributes
        @provider = attributes[:provider]
        @consumer = attributes[:consumer]
        @interactions = []
      end

      def add_interaction interaction
        @interactions << interaction
      end

      def ticket
        Ticket.new(
          :consumer => @consumer,
          :provider => @provider,
          :interactions => @interactions
        )
      end
    end
  end
end