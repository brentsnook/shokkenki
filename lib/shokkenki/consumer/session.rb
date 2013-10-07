require 'shokkenki/consumer/consumer_role'
require 'shokkenki/shokkenki'
require 'shokkenki/consumer/simplification'
require 'shokkenki/consumer/dsl/session'

module Shokkenki
  module Consumer
    class Session
      include Shokkenki::Consumer::Simplification
      include Shokkenki::Consumer::DSL::Session

      attr_reader :consumers, :current_consumer

      def initialize
        @consumers = {}
      end

      def self.singleton
        @instance ||= Session.new
      end

      def current_patronage_for provider_name
        @current_consumer.patronage provider_name
      end

      def current_consumer= consumer_attributes
        name = simplify(consumer_attributes[:name])
        @consumers[name] ||= Shokkenki::Consumer::ConsumerRole.new consumer_attributes
        @current_consumer = @consumers[name]
      end

      def stamped_tickets
        time = Time.now
        # would rather copy + transform tickets rather than modify
        # existing state - something to come back to
        @consumers.values.collect(&:tickets).flatten.map do |ticket|
          ticket.version = Shokkenki::Version::STRING
          ticket.time = time
          ticket
        end
      end

      def print_tickets
        stamped_tickets.each do |ticket|
          ticket_path = File.expand_path(File.join(Shokkenki.configuration.ticket_location, ticket.filename))
          File.open(ticket_path, 'w') { |file| file.write(ticket.to_json) }
        end
      end

    end
  end
end