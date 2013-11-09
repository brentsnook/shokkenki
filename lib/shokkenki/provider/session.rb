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

      def redeem_tickets
        @ticket_reader.read_from(ticket_location).each do |ticket|
          ticket.verify_with providers[ticket.provider.name]
        end
      end
    end
  end
end