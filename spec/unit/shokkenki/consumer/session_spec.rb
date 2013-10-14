require_relative '../../spec_helper'
require 'shokkenki/consumer/session'
require 'shokkenki/consumer/model/role'

describe Shokkenki::Consumer::Session do

  it 'includes the session DSL' do
    expect(subject).to respond_to(:order)
  end

  it 'is configurable' do
    expect(subject).to respond_to(:configure)
  end

  describe 'provider' do
    it 'is always the same when requested by name' do
      provider = subject.provider(:name => :providertron)
      expect(subject.provider(:name => :providertron)).to be(provider)
    end

    it 'is stored and retrieved using a simplified name' do
      provider = subject.provider(:name => :PROvidertron)
      expect(subject.provider(:name => :providertron)).to be(provider)
    end
  end

  describe 'consumer' do

    it 'is always the same when requested by name' do
      consumer = subject.consumer(:name => :consumertron)
      expect(subject.consumer(:name => :consumertron)).to be(consumer)
    end

    it 'is stored and retrieved using a simplified name' do
      consumer = subject.consumer(:name => :CONsumertron)
      expect(subject.consumer(:name => :consumertron)).to be(consumer)
    end
  end

  describe 'current patronage' do

    before do
      subject.current_consumer = {:name => :consumertron}
    end

    let(:patronage) { subject.current_patronage_for(:providertron) }

    it 'is for the current consumer' do
      expect(patronage.consumer.name).to eq(:consumertron)
    end

    it 'is of the given provider' do
      expect(patronage.provider.name).to eq(:providertron)
    end

  end

  context 'setting the current consumer' do
    context 'when a consumer with that name is not already registered' do
      let(:new_consumer) { double 'new consumer' }

      before do
        allow(Shokkenki::Consumer::Model::Role).to receive(:new).and_return(new_consumer)
        subject.current_consumer = {:name => :consumertron}
      end

      it 'creates a new consumer with that name' do
        expect(Shokkenki::Consumer::Model::Role).to have_received(:new).with hash_including(:name => :consumertron)
      end

      it 'registers the consumer' do
        expect(subject.consumer(:name => :consumertron)).to be(new_consumer)
      end

    end

    context 'when a consumer with that name is already registered' do

      let(:existing_consumer) { subject.consumer(:name => :consumertron) }
      before { subject.current_consumer = {:name => :consumertron} }

      it 'uses the existing consumer' do
        expect(subject.current_consumer).to be(existing_consumer)
      end

    end

  end

  context 'clearing interaction stubs' do

    let(:provider) { subject.provider(:name => :providertron) }
    before do
      allow(provider).to receive(:clear_interaction_stubs)
      subject.clear_interaction_stubs
    end

    it 'clears the interaction stubs for each provider' do
      expect(provider).to have_received(:clear_interaction_stubs)
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
      subject.patronages.merge!({
         :key => double('patronage', :ticket => ticket)
      })
      allow(File).to receive(:open).and_yield file
      subject.ticket_location = 'ticket_dir'

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

  context 'when started' do
    let(:provider) { subject.provider(:name => :providertron) }
    before do
      allow(provider).to receive(:session_started)
      subject.start
    end

    it 'notifies all providers of the start' do
      expect(provider).to have_received(:session_started)
    end
  end

  context 'when closed' do
    let(:provider) { subject.provider(:name => :providertron) }
    before do
      allow(provider).to receive(:session_closed)
      subject.close
    end

    it 'notifies all providers of the close' do
      expect(provider).to have_received(:session_closed)
    end
  end
end