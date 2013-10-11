require_relative '../../spec_helper'
require 'shokkenki/consumer/session'
require 'shokkenki/consumer/model/role'

describe Shokkenki::Consumer::Session do

  it 'includes the session DSL' do
    expect(subject).to respond_to(:order)
  end

  context 'being configured' do

    let(:configuration) { double('configuration').as_null_object }

    before do
      allow(subject).to receive(:configuration).and_return configuration
    end

    context 'with directives' do
      before do
        subject.configure do |config|
          config.some_directive 'some value'
        end
      end

      it 'applies those to the configuration' do
        expect(configuration).to have_received(:some_directive).with('some value')
      end
    end

    context 'with no directives' do
      before { subject.configure }

      it 'applies nothing' do
        expect(configuration).to_not have_received(anything)
      end
    end
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
      allow(subject.configuration).to receive(:ticket_location).and_return 'ticket_dir'

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