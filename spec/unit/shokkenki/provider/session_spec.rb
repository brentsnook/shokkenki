require_relative '../../spec_helper'
require 'shokkenki/provider/session'
require 'shokkenki/provider/ticket_reader'

describe Shokkenki::Provider::Session do

  it 'is configurable' do
    expect(subject).to respond_to(:configure)
  end

  context 'by default' do
    it "reads tickets from the 'tickets' directory" do
      expect(subject.ticket_location).to eq('tickets')
    end
  end

  context 'adding a provider' do
    let(:provider) { double('provider', :name => :provider_name)}

    before do
      subject.add_provider provider
    end

    it 'adds the provider to the collection' do
      expect(subject.providers[:provider_name]).to be(provider)
    end

    context 'when a provider already exists with that name' do
      let(:new_provider) { double('new provider', :name => :provider_name)}
      before { subject.add_provider new_provider }

      it 'clobbers the previous provider' do
        expect(subject.providers[:provider_name]).to be(new_provider)
      end
    end
  end

  context 'redeeming tickets' do
    let(:ticket) do
      double('ticket',
        :provider => double('ticket provider', :name => :provider)
      ).as_null_object
    end
    let(:ticket2) do
      double('ticket',
        :provider => double('ticket2 provider', :name => :provider2)
      ).as_null_object
    end
    let(:provider) { double 'provider' }
    let(:provider2) { double 'provider2' }
    let(:ticket_reader) { double('ticket reader', :read_from => [ticket, ticket2]) }

    before do
      allow(Shokkenki::Provider::TicketReader).to receive(:new).and_return ticket_reader
      subject.ticket_location = 'ticket location'
      subject.providers[:provider] = provider
      subject.providers[:provider2] = provider2
    end

    context 'when all providers are found' do
      before do
        subject.redeem_tickets
      end

      it 'reads tickets from the configured ticket location' do
        expect(ticket_reader).to have_received(:read_from).with 'ticket location'
      end

      it 'verifies each ticket with its provider' do
        expect(ticket).to have_received(:verify_with).with provider
        expect(ticket2).to have_received(:verify_with).with provider2
      end
    end

    context 'when no provider is found' do
      let(:ticket) do
        double('ticket with no provider',
          :provider => double('ticket provider', :name => :unknown_provider)
        ).as_null_object
      end

      it 'raises an error' do
        expect { subject.redeem_tickets }.to raise_error("No provided named 'unknown_provider' was found. Did you register one?")
      end
    end
  end
end