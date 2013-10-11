require 'shokkenki/shokkenki'
require 'shokkenki/consumer/model/role'
require 'shokkenki/consumer/model/patronage'
require 'shokkenki/consumer/model/simplification'
require 'shokkenki/consumer/dsl/session'
require 'shokkenki/consumer/configuration'

module Shokkenki
  module Consumer
    class Session
      include Shokkenki::Consumer::Model::Simplification
      include Shokkenki::Consumer::DSL::Session

      attr_reader :current_consumer, :patronages, :configuration

      def initialize
        @consumers = {}
        @providers = {}
        @patronages = {}
        @configuration = Shokkenki::Consumer::Configuration.new
      end

      def configure
        yield configuration if block_given?
      end

      def current_patronage_for provider_name
        consumer = @current_consumer
        provider = provider(:name => provider_name)
        key = { consumer => provider }
        @patronages[key] ||= Shokkenki::Consumer::Model::Patronage.new :consumer => consumer, :provider => provider
      end

      def provider attributes
        name = simplify(attributes[:name])
        @providers[name] ||= Shokkenki::Consumer::Model::Role.new attributes
      end

      def consumer attributes
        name = simplify(attributes[:name])
        @consumers[name] ||= Shokkenki::Consumer::Model::Role.new attributes
      end

      def current_consumer= attributes
        @current_consumer = consumer attributes
      end

      def print_tickets
        @patronages.values.collect(&:ticket).each do |ticket|
          ticket_path = File.expand_path(File.join(configuration.ticket_location, ticket.filename))
          File.open(ticket_path, 'w') { |file| file.write(ticket.to_json) }
        end
      end

    end
  end
end