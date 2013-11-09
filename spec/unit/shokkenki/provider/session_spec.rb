require_relative '../../spec_helper'
require 'shokkenki/provider/session'
require 'shokkenki/provider/ticket_reader'

describe Shokkenki::Provider::Session do
  context 'redeeming tickets' do
    let(:ticket) { double 'ticket' }
    let(:ticket2) { double 'ticket2' }
    let(:ticket_reader) { double('ticket reader', :read_from => [ticket, ticket2]) }
    let(:ticket_verifier) { double('ticket verifier').as_null_object }

    before do
      allow(Shokkenki::Provider::TicketReader).to receive(:new).and_return ticket_reader
      subject.ticket_verifier = ticket_verifier
      subject.ticket_location = 'ticket location'

      subject.redeem_tickets
    end

    it 'reads tickets from the configured ticket location' do
      expect(ticket_reader).to have_received(:read_from).with 'ticket location'
    end

    it 'verifies each ticket' do
      expect(ticket_verifier).to have_received(:verify_all).with [ticket, ticket2]
    end
  end
end