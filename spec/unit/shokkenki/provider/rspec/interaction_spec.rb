require_relative '../../../spec_helper'
require 'shokkenki/provider/rspec/interaction'

describe Shokkenki::Provider::RSpec::Interaction do
  context 'verifying within a context' do
    class InteractionStub
      include Shokkenki::Provider::RSpec::Interaction
    end

    subject { InteractionStub.new }

    let(:example_context) { double('example context').as_null_object }
    let(:example_state) do
      state = ''
      state.instance_variable_set :@provider, provider
      state
    end
    let(:response) { double('response').as_null_object }
    let(:http_response) { double('http response').as_null_object }
    let(:provider) { double('provider', :http_client => http_client, :establish => '') }
    let(:http_client) { double('http client')}
    let(:request) { double('request').as_null_object }
    let(:required_fixtures) { [double('required fixture')] }

    before do
      allow(subject).to receive(:label).and_return('interaction label')
      allow(subject).to receive(:response).and_return(response)
      allow(subject).to receive(:request).and_return(request)
      allow(subject).to receive(:required_fixtures).and_return(required_fixtures)
      allow(http_client).to receive(:response_for).with(request).and_return(http_response)

      allow(example_context).to receive(:describe) do |&block|
        example_context.instance_eval &block
      end
      allow(example_context).to receive(:before) do |&block|
        example_state.instance_eval &block
      end

      subject.verify_within example_context
    end

    it 'describes the interaction by label' do
      expect(example_context).to have_received(:describe).with 'interaction label'
    end

    it 'verifies the response in the current context' do
      expect(response).to have_received(:verify_within).with(example_context)
    end

    context 'before all examples' do

      it 'establishes each required provider fixture' do
        expect(provider).to have_received(:establish).with required_fixtures
      end

      it 'retrieves the provider http response' do
        expect(example_state.instance_variable_get(:@http_response)).to be(http_response)
      end

    end

    # this is so we don't clobber the original request if actual_values is re-assigned
    it 'exposes the provider http response as actual values' do
      expect(example_context).to have_received(:before).with(:each)
      expect(example_state.instance_variable_get(:@actual_values)).to be(http_response)
    end
  end
end