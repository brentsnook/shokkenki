require_relative 'ticket_reader'
require_relative 'configuration/session'

module Shokkenki
  module Provider
    class Session
      include Shokkenki::Provider::Configuration::Session

      attr_accessor :ticket_location
      attr_reader :providers

      def initialize
        @ticket_reader = TicketReader.new
        @ticket_location = 'tickets'
        @providers = {}
      end

      def add_provider provider
        @providers[provider.name] = provider
      end

      def configure &block
        instance_eval &block
      end

      def redeem_tickets &block
        configure(&block) if block
        @ticket_reader.read_from(ticket_location).each do |ticket|
          provider = providers[ticket.provider.name]
          raise "No provided named '#{ticket.provider.name}' was found. Did you register one?" unless provider
          ticket.verify_with provider
        end
      end
    end
  end
end