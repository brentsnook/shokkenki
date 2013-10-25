require_relative 'ticket'

module Shokkenki
  module Consumer
    module Model
      class Patronage

        attr_reader :provider, :consumer, :interactions

        def initialize attributes
          @provider = attributes[:provider]
          @consumer = attributes[:consumer]
          @interactions = []
        end

        def add_interaction interaction
          @interactions << interaction
          @provider.stub_interaction interaction
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
end