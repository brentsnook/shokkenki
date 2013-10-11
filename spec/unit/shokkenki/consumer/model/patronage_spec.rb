require_relative '../../../spec_helper'
require 'shokkenki/consumer/model/ticket'
require 'shokkenki/consumer/model/patronage'

describe Shokkenki::Consumer::Model::Patronage do

  let(:consumer) { double('consumer').as_null_object }
  let(:provider) { double('provider').as_null_object }

  subject { Shokkenki::Consumer::Model::Patronage.new :provider => provider, :consumer => consumer}

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

    it 'stubs the interaction on the provider' do
      expect(provider).to have_received(:stub_interaction).with(interaction)
    end
  end

  describe 'ticket' do

    let(:interaction) { double('interaction') }

    before do
      allow(Shokkenki::Consumer::Model::Ticket).to receive(:new)
      subject.interactions << interaction

      subject.ticket
    end

    it 'has the interactions' do
      expect(Shokkenki::Consumer::Model::Ticket).to have_received(:new).with(hash_including(:interactions => [interaction]))
    end

    it 'has the consumer' do
      expect(Shokkenki::Consumer::Model::Ticket).to have_received(:new).with(hash_including(:consumer => consumer))
    end

    it 'has the provider' do
      expect(Shokkenki::Consumer::Model::Ticket).to have_received(:new).with(hash_including(:provider => provider))
    end
  end
end