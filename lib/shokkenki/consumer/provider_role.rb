require 'shokkenki/consumer/ticket'

module Shokkenki
  module Consumer
  	class ProviderRole

      attr_reader :name, :consumer

      def initialize attributes
      	@name = attributes[:name]
      	@consumer = attributes[:consumer]
      end

      def ticket
        Ticket.new :consumer => @consumer.name, :provider => @name
      end
  	end
  end
end