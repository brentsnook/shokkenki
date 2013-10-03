require_relative '../../spec_helper'
require 'shokkenki/consumer/consumer_role'
require 'shokkenki/consumer/patronage'

describe Shokkenki::Consumer::ConsumerRole do
  context 'when created' do
    subject { Shokkenki::Consumer::ConsumerRole.new :name => :Consumatron}

    it 'simplifies the name it is given' do
      expect(subject.name).to eq(:consumatron)
    end

    it 'has no patronages' do
      expect(subject.patronages).to be_empty
    end

  end

  context 'retrieving a patronage' do

    subject { Shokkenki::Consumer::ConsumerRole.new({}) }

    context 'when a patronage doesnt exist for the provider' do

      let(:new_patronage) { double 'new patronage' }

      before do
        allow(Shokkenki::Consumer::Patronage).to receive(:new).and_return new_patronage
        subject.patronage(:my_provider)
      end

      it 'creates a new patronage with the given name and its self as the consumer' do
        expect(Shokkenki::Consumer::Patronage).to have_received(:new).with(:consumer => subject, :name => :my_provider)
      end

      it 'retrieves the newly created provider for subsequent requests' do
        expect(subject.patronage(:my_provider)).to be(new_patronage)
      end
    end

    context 'when a patronage already exists for the provider' do

      let(:existing_patronage) { double 'patronage' }

      before do
        subject.patronages[:my_provider] = existing_patronage
      end

      it 'retrieves the existing patronage' do
        expect(subject.patronage(:my_provider)).to be(existing_patronage)
      end

      it 'simplifies the provider name' do
        expect(subject.patronage(:MY_provider)).to be(existing_patronage)
      end
    end
  end

  context 'collecting tickets' do

    subject { Shokkenki::Consumer::ConsumerRole.new({}) }

    before do
      subject.patronages.merge!(
        :provider1 => double('patronage1', :ticket => 'ticket1'),
        :provider2 => double('patronage2', :ticket => 'ticket2')
      )
    end

    it 'collects the tickets of all of its patronages' do
      expect(subject.tickets).to eq(['ticket1', 'ticket2'])
    end
  end
end
