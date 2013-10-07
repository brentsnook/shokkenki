require_relative '../../spec_helper'
require 'shokkenki/consumer/ticket'
require 'shokkenki/consumer/patronage'

describe Shokkenki::Consumer::Patronage do
  context 'when created' do

    let(:consumer) { double 'consumer' }

    subject { Shokkenki::Consumer::Patronage.new :name => :Providertron, :consumer => consumer}

    it 'simplifies the provider name it is given' do
      expect(subject.name). to eq(:providertron)
    end

    it 'has the consumer it is given' do
      expect(subject.consumer).to be(consumer)
    end
  end

  context 'during' do

    subject { Shokkenki::Consumer::Patronage.new :name => :providertron, :consumer => double('consumer')}

    it 'starts a new interaction with the given label' do
      expect(subject.during('an awesome interaction').label).to eq('an awesome interaction')
    end

    it 'doesnt allow duplicate interactions'
  end

  describe 'ticket' do

    let(:consumer) { double 'consumer', :name => :consumertron }
    subject { Shokkenki::Consumer::Patronage.new :name => :providertron, :consumer => consumer}

    before do
      allow(Shokkenki::Consumer::Ticket).to receive(:new)
      subject.ticket
    end

    it 'has the consumer name' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:consumer => :consumertron))
    end

    it 'has the provider name' do
      expect(Shokkenki::Consumer::Ticket).to have_received(:new).with(hash_including(:provider => :providertron))
    end
  end
end