require_relative '../../../spec_helper'
require 'shokkenki/provider/rspec/ticket'

describe Shokkenki::Provider::RSpec::Ticket do
  context 'verifying with a provider' do

    class TicketStub
      include Shokkenki::Provider::RSpec::Ticket
    end
    subject { TicketStub.new }

    let(:consumer) { double 'consumer', :label => 'Consumer label' }
    let(:interaction) { double('interaction', :label => 'interaction label').as_null_object }
    let(:provider) { double 'provider' }
    let(:example_context) { double('example').as_null_object }
    let(:example_state) { '' }

    before do
      allow(subject).to receive(:consumer).and_return consumer
      allow(subject).to receive(:interactions).and_return [interaction]

      allow(subject).to receive(:describe) do |&block|
        example_context.instance_eval &block
      end

      allow(example_context).to receive(:before).with(:all) do |&block|
        example_state.instance_eval &block
      end

      subject.verify_with provider
    end

    it 'describes the consumer by label' do
      expect(subject).to have_received(:describe).with('Consumer label', anything)
    end

    it 'exposes the provider to the context' do
      expect(example_state.instance_variable_get(:@provider)).to be(provider)
    end

    it 'tags the examples as shokkenki_provider to allow filtering' do
      expect(subject).to have_received(:describe).with(anything, :shokkenki_provider => true)
    end

    it 'verifies each interaction in the current context' do
      expect(interaction).to have_received(:verify_within).with(example_context)
    end

  end
end