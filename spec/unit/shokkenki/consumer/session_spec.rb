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

  context 'by default' do
    it "writes tickets to the 'tickets' directory" do
      expect(subject.ticket_location).to eq('tickets')
    end
  end

  describe 'provider' do
    let(:provider) { double('provider', :name => :providername)}

    before do
      subject.add_provider provider
    end

    it 'is retrieved using a simplified name' do
      expect(subject.provider(:PROVidername)).to be(provider)
    end
  end

  describe 'adding a provider' do
    let(:provider) { double('provider', :name => :providerNAME)}

    before do
      subject.add_provider provider
    end

    it 'adds the provider to the list of providers with a simplified name' do
      expect(subject.providers[:providername]).to be(provider)
    end
  end

  describe 'adding a consumer' do
    let(:consumer) { double('consumer', :name => :consumerNAME)}

    before do
      subject.add_consumer consumer
    end

    it 'adds the consumer to the list of consumers with a simplified name' do
      expect(subject.consumers[:consumername]).to be(consumer)
    end
  end

  describe 'consumer' do
    let(:consumer) { double('consumer', :name => :consumername)}

    before do
      subject.add_consumer consumer
    end

    it 'is retrieved using a simplified name' do
      expect(subject.consumer(:CONSUMername)).to be(consumer)
    end
  end

  describe 'current patronage' do

   let(:provider) { double('provider', :name => :providername)}
   let(:consumer) { double('consumer', :name => :consumername)}

    before do
      subject.add_consumer consumer
      subject.set_current_consumer :consumername
    end

    let(:patronage) { subject.current_patronage_for(:providername) }

    context 'the provider exists' do

      before { subject.add_provider provider }

      it 'is for the current consumer' do
        expect(patronage.consumer.name).to eq(:consumername)
      end

      it 'is of the given provider' do
        expect(patronage.provider.name).to eq(:providername)
      end
    end

    context 'when the provider does not exist' do
      it 'fails' do
        expect{patronage}.to raise_error("The provider 'providername' is not recognised. Have you defined it?")
      end
    end

  end

  context 'setting the current consumer' do
   let(:consumer) { double('consumer', :name => :consumername)}

    before do
      subject.add_consumer consumer
      subject.set_current_consumer :consumername
    end

    it 'sets the current consumer to that with the given name' do
      expect(subject.current_consumer).to be(consumer)
    end

  end

  context 'clearing interaction stubs' do
    let(:provider) { double('provider', :name => :providername)}

    before do
      subject.add_provider provider
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
    let(:provider) { double('provider', :name => :providername)}

    before do
      subject.add_provider provider
      allow(provider).to receive(:session_started)
      subject.start
    end

    it 'notifies all providers of the start' do
      expect(provider).to have_received(:session_started)
    end
  end

  context 'when closed' do
    let(:provider) { double('provider', :name => :providername)}

    before do
      subject.add_provider provider
      allow(provider).to receive(:session_closed)
      subject.close
    end

    it 'notifies all providers of the close' do
      expect(provider).to have_received(:session_closed)
    end
  end

  context 'asserting that all requests matched' do
    let(:provider) { double('provider', :name => :providername).as_null_object }

    before do
      subject.add_provider provider
      allow(provider).to receive(:clear_interaction_stubs)
      subject.assert_all_requests_matched!
    end

    it 'asserts that requests matched on all providers' do
      expect(provider).to have_received(:assert_all_requests_matched!)
    end
  end

  context 'asserting that all interactions were used' do
    let(:provider) { double('provider', :name => :providername).as_null_object }

    before do
      subject.add_provider provider
      allow(provider).to receive(:clear_interaction_stubs)
      subject.assert_all_interactions_used!
    end

    it 'asserts that interactions were used on all providers' do
      expect(provider).to have_received(:assert_all_interactions_used!)
    end
  end
end