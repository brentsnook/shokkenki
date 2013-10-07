require_relative '../../spec_helper'
require 'shokkenki/consumer/ticket'
require 'shokkenki/consumer/patronage'

describe Shokkenki::Consumer::Patronage do

  let(:consumer) { double 'consumer' }
  subject { Shokkenki::Consumer::Patronage.new :name => :providertron, :consumer => consumer}

  context 'when created' do
    subject { Shokkenki::Consumer::Patronage.new :name => :PROvidertron, :consumer => consumer}

    it 'simplifies the provider name it is given' do
      expect(subject.name). to eq(:providertron)
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
      allow(consumer).to receive(:name).and_return(:consumertron)
      allow(Shokkenki::Consumer::Ticket).to receive(:new)
      subject.interactions << interaction

      subject.ticket
    end

    it 'has the interactions' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:interactions => [interaction]))
    end

    it 'has the consumer name' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:consumer => :consumertron))
    end

    it 'has the provider name' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:provider => :providertron))
    end
  end
end