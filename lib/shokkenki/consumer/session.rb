require_relative '../shokkenki'
require_relative 'model/patronage'
require_relative 'model/simplification'
require_relative 'dsl/session'
require_relative 'configuration/session'

module Shokkenki
  module Consumer
    class Session
      include Shokkenki::Consumer::Model::Simplification
      include Shokkenki::Consumer::DSL::Session
      include Shokkenki::Consumer::Configuration::Session

      attr_reader :current_consumer, :patronages, :configuration, :providers, :consumers
      attr_accessor :ticket_location

      def initialize
        @consumers = {}
        @providers = {}
        @patronages = {}
      end

      def current_patronage_for provider_name
        consumer = @current_consumer
        provider = provider(provider_name) || raise("The provider '#{provider_name}' is not recognised. Have you defined it?")
        key = { consumer => provider }
        @patronages[key] ||= Shokkenki::Consumer::Model::Patronage.new :consumer => consumer, :provider => provider
      end

      def add_provider provider
        @providers[simplify(provider.name)] = provider
      end

      def add_provider provider
        @providers[simplify(provider.name)] = provider
      end

      def add_consumer consumer
        @consumers[simplify(consumer.name)] = consumer
      end

      def provider name
        @providers[simplify(name)]
      end

      def consumer name
        @consumers[simplify(name)]
      end

      def set_current_consumer name
        @current_consumer = consumer name
      end

      def clear_interaction_stubs
        @providers.values.each { |p| p.clear_interaction_stubs }
      end

      def start
        @providers.values.each { |p| p.session_started }
      end

      def close
        @providers.values.each { |p| p.session_closed }
      end

      def print_tickets
        @patronages.values.collect(&:ticket).each do |ticket|
          ticket_path = File.expand_path(File.join(ticket_location, ticket.filename))
          File.open(ticket_path, 'w') { |file| file.write(ticket.to_json) }
        end
      end

      def assert_all_requests_matched!
        @providers.values.each { |p| p.assert_all_requests_matched! }
      end

      def assert_all_interactions_used!
        @providers.values.each { |p| p.assert_all_interactions_used! }
      end

    end
  end
end