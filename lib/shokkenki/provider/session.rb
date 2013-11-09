require_relative 'ticket_reader'

module Shokkenki
  module Provider
    class Session

      attr_accessor :ticket_location
      attr_accessor :ticket_verifier

      def initialize
        @ticket_reader = TicketReader.new
        @ticket_location = 'tickets'
      end

      def redeem_tickets
        @ticket_verifier.verify_all @ticket_reader.read_from(ticket_location)
      end
    end
  end
end