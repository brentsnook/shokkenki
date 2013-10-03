require_relative '../../spec_helper'
require 'shokkenki/consumer/consumer_role'
require 'shokkenki/consumer/provider_role'

describe Shokkenki::Consumer::ConsumerRole do
  context 'when created' do
    subject { Shokkenki::Consumer::ConsumerRole.new :name => 'consumatron'}

    it 'has the name it is given' do
      expect(subject.name).to eq('consumatron')
    end

    it 'has no providers' do
      expect(subject.providers).to be_empty
    end

  end

  context 'retrieving a provider' do

    subject { Shokkenki::Consumer::ConsumerRole.new({}) }

    context 'when the provider does not already exist' do

      let(:new_provider) { double 'new provider' }

      before do
        allow(Shokkenki::Consumer::ProviderRole).to receive(:new).and_return new_provider
        subject.provider(:my_provider)
      end

      it 'creates a new provider role with the given name and its self as the consumer' do
        expect(Shokkenki::Consumer::ProviderRole).to have_received(:new).with(:consumer => subject, :name => :my_provider)
      end

      it 'retrieves the newly created provider for subsequent requests' do
        expect(subject.provider(:my_provider)).to be(new_provider)
      end
    end

    context 'when the provider already exists' do

      let(:existing_provider) { double 'provider' }

      before do
        subject.providers[:my_provider] = existing_provider
      end

      it 'retrieves the existing provider' do
        expect(subject.provider(:my_provider)).to be(existing_provider)
      end
    end
  end

  context 'collecting tickets' do

    subject { Shokkenki::Consumer::ConsumerRole.new({}) }

    before do
      subject.providers.merge!(
        :provider1 => double('provider1', :ticket => 'ticket1'),
        :provider2 => double('provider2', :ticket => 'ticket2')
      )
    end

    it 'collects the tickets of all of its providers' do
      expect(subject.tickets).to eq(['ticket1', 'ticket2'])
    end
  end
end
