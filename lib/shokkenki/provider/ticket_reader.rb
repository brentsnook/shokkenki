require_relative 'model/ticket'

module Shokkenki
  module Provider
    class TicketReader

      def read_from location
        [Model::Ticket.new]
      end

    end
  end
end