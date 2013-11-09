require_relative '../../../spec_helper'
require 'shokkenki/provider/rspec/interaction'

describe Shokkenki::Provider::RSpec::Interaction do
  context 'verifying within a context' do
    class InteractionStub
      include Shokkenki::Provider::RSpec::Interaction
    end

    subject { InteractionStub.new }

    let(:example_context) { double('example context').as_null_object }
    let(:response) { double('response').as_null_object }

    before do
      allow(example_context).to receive(:describe) do |&block|
        example_context.instance_eval &block
      end
      allow(subject).to receive(:label).and_return('interaction label')
      allow(subject).to receive(:response).and_return(response)

      subject.verify_within example_context
    end

    it 'describes the interaction by label' do
      expect(example_context).to have_received(:describe).with 'interaction label'
    end

    it 'verifies the response in the current context' do
      expect(response).to have_received(:verify_within).with(example_context)
    end

    it 'exposes actual values' do
      expect(example_context).to have_received(:let).with(:actual_values)
    end

    it 'exposes the provider response as actual values'
  end
end