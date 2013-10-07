require_relative '../../spec_helper'
require 'shokkenki/consumer/session'
require 'shokkenki/consumer/consumer_role'

describe Shokkenki::Consumer::Session do

  # testing frameworks like RSpec require a singleton to maintain state
  # between hooks
  it 'has a singleton to maintain state' do
    expect(Shokkenki::Consumer::Session.singleton).to_not be_nil
  end

  it 'includes the session DSL' do
    expect(subject).to respond_to(:order)
  end

  describe 'current patronage' do

    before do
      subject.current_consumer = {:name => :consumertron}
    end

    it "is the current consumer's patronage of the given provider" do
      expect(subject.current_patronage_for(:providertron)).to be(subject.current_consumer.patronage(:providertron))
    end
  end

  context 'setting the current consumer' do
    context 'when a consumer with that name is not already registered' do
      let(:new_consumer) { double 'new consumer' }

      before do
        allow(Shokkenki::Consumer::ConsumerRole).to receive(:new).and_return(new_consumer)
        subject.current_consumer = {:name => :consumertron}
      end

      it 'creates a new consumer with that name' do
        expect(Shokkenki::Consumer::ConsumerRole).to have_received(:new).with hash_including(:name => :consumertron)
      end

      it 'registers the consumer' do
        expect(subject.consumers[:consumertron]).to be(new_consumer)
      end

    end

    context 'when a consumer with that name is already registered' do

      let(:existing_consumer) { double 'existing consumer' }

      before do
        subject.consumers[:consumertron] = existing_consumer
        subject.current_consumer = {:name => :consumertron }
      end

      it 'uses the existing consumer' do
        expect(subject.current_consumer).to be(existing_consumer)
      end

    end

    context 'when registering a consumer' do
      before do
        subject.current_consumer = {:name => :CONsumertron}
      end

      it 'simplfies the consumer name' do
        expect(subject.consumers[:consumertron]).to_not be_nil
      end
    end
  end

  context 'printing tickets' do

    let(:file) { double('file').as_null_object }
    let(:ticket) do
      double('ticket',
        :to_json => 'ticket json',
        :filename => 'ticketfilename'
      )
    end

    before do
      subject.consumers.merge!({
        :consumer => double('consumer', :tickets => [ticket])
      })
      allow(File).to receive(:open).and_yield file
      allow(Shokkenki.configuration).to receive(:ticket_location).and_return 'ticket_dir'

      subject.print_tickets
    end

    it 'writes the contents of each consumer ticket' do
      expect(file).to have_received(:write).with 'ticket json'
    end

    it 'writes each consumer ticket to the ticket directory' do
      expect(File).to have_received(:open).with %r{ticket_dir/ticketfilename}, anything
    end

    it 'overwrites ticket files' do
      expect(File).to have_received(:open).with(anything, 'w')
    end
  end
end