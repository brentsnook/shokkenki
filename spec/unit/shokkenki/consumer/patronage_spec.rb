require_relative '../../spec_helper'
require 'shokkenki/consumer/ticket'
require 'shokkenki/consumer/patronage'

describe Shokkenki::Consumer::Patronage do

  let(:consumer) { double 'consumer' }
  let(:provider) { double 'provider' }

  subject { Shokkenki::Consumer::Patronage.new :provider => provider, :consumer => consumer}

  context 'when created' do

    it 'has the provider it is given' do
      expect(subject.provider).to be(provider)
    end

    it 'has the consumer it is given' do
      expect(subject.consumer).to be(consumer)
    end
  end

  context 'adding an interaction' do

    let(:interaction) { double 'interaction' }

    before do
      subject.add_interaction interaction
    end

    it 'adds an interaction to the list for this patronage' do
      expect(subject.interactions).to include(interaction)
    end
  end

  describe 'ticket' do

    let(:interaction) { double('interaction') }

    before do
      allow(Shokkenki::Consumer::Ticket).to receive(:new)
      subject.interactions << interaction

      subject.ticket
    end

    it 'has the interactions' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:interactions => [interaction]))
    end

    it 'has the consumer' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:consumer => consumer))
    end

    it 'has the provider' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:provider => provider))
    end
  end
end