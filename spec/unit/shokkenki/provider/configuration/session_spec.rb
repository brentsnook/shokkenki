require_relative '../../../spec_helper'
require 'shokkenki/provider/configuration/session'
require 'shokkenki/provider/model/provider'

describe Shokkenki::Provider::Configuration::Session do

  class StubSession
    include Shokkenki::Provider::Configuration::Session
    attr_accessor :ticket_location
    attr_reader :providers

    def initialize
      @providers = {}
    end
  end

  subject { StubSession.new }

  it 'allows ticket location to be specified' do
    subject.tickets 'location'
    expect(subject.ticket_location).to eq('location')
  end

  context 'defining a provider' do
    let(:provider) { double('provider configuration').as_null_object }

    before do
      allow(Shokkenki::Provider::Model::Provider).to receive(:new).and_return(provider)
      allow(subject).to receive(:add_provider)
    end

    context 'with configuration directives' do
      before { subject.provider(:provider_name) { directive } }
      it 'creates a new provider with the given name' do
        expect(Shokkenki::Provider::Model::Provider).to have_received(:new).with(:provider_name)
      end

      it 'allows the provider to be configured' do
        expect(provider).to have_received(:directive)
      end

      it 'registers the provider' do
        expect(subject).to have_received(:add_provider).with(provider)
      end
    end

    context 'without any configuration directives' do
      before { subject.provider(:provider_name) }
      it "doesn't configure the provider" do
        expect(provider).to_not have_received(anything)
      end
    end
  end
end