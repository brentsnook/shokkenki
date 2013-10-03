require 'shokkenki/consumer/ticket'
require 'shokkenki/consumer/simplification'

module Shokkenki
  module Consumer
    class Patronage
      include Shokkenki::Consumer::Simplification

      attr_reader :name, :consumer

      def initialize attributes
        @name = simplify(attributes[:name])
        @consumer = attributes[:consumer]
      end

      def ticket
        Ticket.new :consumer => @consumer.name, :provider => @name
      end
    end
  end
end