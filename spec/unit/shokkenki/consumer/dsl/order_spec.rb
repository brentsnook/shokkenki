require_relative '../../../spec_helper'
require 'shokkenki/consumer/dsl/order'
require 'shokkenki/consumer/request'
require 'shokkenki/consumer/interaction'

describe Shokkenki::Consumer::DSL::Order do

  before do
    allow(Shokkenki::Consumer::Request).to receive(:new)
    allow(Shokkenki::Consumer::Response).to receive(:new)
    allow(Shokkenki::Consumer::Interaction).to receive(:new)
  end

  context 'provider' do
    before do
      subject.provider :providertron
    end

    it 'defines the provider that is being interacted with' do
      expect(subject.provider_name).to eq(:providertron)
    end
  end

  context 'during' do
    before do
      subject.during 'my label'
      subject.to_interaction
    end

    it 'defines the response of the interaction' do
      expect(Shokkenki::Consumer::Interaction).to have_received(:new).with(hash_including(:label => 'my label'))
    end
  end

  context 'requested with' do
    let(:request) { double 'request' }
    let(:request_attributes) { double 'request attributes' }

    before do
      allow(Shokkenki::Consumer::Request).to(
        receive(:new).with(request_attributes)
        .and_return(request)
      )

      subject.requested_with request_attributes
      subject.to_interaction
    end

    it 'defines the request of the interaction' do
      expect(Shokkenki::Consumer::Interaction).to have_received(:new).with(hash_including(:request => request))
    end
  end

  context 'responds with' do
    let(:response) { double 'response' }
    let(:response_attributes) { double 'response attributes' }

    before do
      allow(Shokkenki::Consumer::Response).to(
        receive(:new).with(response_attributes)
        .and_return(response)
      )

      subject.responds_with response_attributes
      subject.to_interaction
    end

    it 'defines the response of the interaction' do
      expect(Shokkenki::Consumer::Interaction).to have_received(:new).with(hash_including(:response => response))
    end
  end

end