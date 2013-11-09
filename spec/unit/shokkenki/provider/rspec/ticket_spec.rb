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
    let(:provider_config) { double 'provider' }
    let(:example_context) { double('example').as_null_object }

    before do
      allow(subject).to receive(:consumer).and_return consumer
      allow(subject).to receive(:interactions).and_return [interaction]

      allow(subject).to receive(:describe) do |&block|
        example_context.instance_eval &block
      end

      subject.verify_with provider_config
    end

    it 'describes the consumer by label' do
      expect(subject).to have_received(:describe).with('Consumer label')
    end

    it 'verifies each interaction in the current context' do
      expect(interaction).to have_received(:verify_within).with(example_context)
    end

  end
end