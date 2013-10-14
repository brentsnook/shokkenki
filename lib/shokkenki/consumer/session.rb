require 'shokkenki/shokkenki'
require 'shokkenki/consumer/model/role'
require 'shokkenki/consumer/model/provider'
require 'shokkenki/consumer/model/patronage'
require 'shokkenki/consumer/model/simplification'
require 'shokkenki/consumer/dsl/session'
require 'shokkenki/consumer/configuration/session'

module Shokkenki
  module Consumer
    class Session
      include Shokkenki::Consumer::Model::Simplification
      include Shokkenki::Consumer::DSL::Session
      include Shokkenki::Consumer::Configuration::Session

      attr_reader :current_consumer, :patronages, :configuration

      def initialize
        @consumers = {}
        @providers = {}
        @patronages = {}
      end

      def current_patronage_for provider_name
        consumer = @current_consumer
        provider = provider(:name => provider_name)
        key = { consumer => provider }
        @patronages[key] ||= Shokkenki::Consumer::Model::Patronage.new :consumer => consumer, :provider => provider
      end

      def provider attributes
        name = simplify(attributes[:name])
        @providers[name] ||= Shokkenki::Consumer::Model::Provider.new attributes
      end

      def consumer attributes
        name = simplify(attributes[:name])
        @consumers[name] ||= Shokkenki::Consumer::Model::Role.new attributes
      end

      def current_consumer= attributes
        @current_consumer = consumer attributes
      end

      def clear_interaction_stubs
        @providers.values.each { |p| p.clear_interaction_stubs }
      end

      def print_tickets
        @patronages.values.collect(&:ticket).each do |ticket|
          ticket_path = File.expand_path(File.join(ticket_location, ticket.filename))
          File.open(ticket_path, 'w') { |file| file.write(ticket.to_json) }
        end
      end

    end
  end
end