require_relative '../../spec_helper'
require 'shokkenki/consumer/interaction'
require 'shokkenki/consumer/request'
require 'shokkenki/consumer/response'

describe Shokkenki::Consumer::Interaction do

  subject { Shokkenki::Consumer::Interaction.new(:label => 'interaction label') }

  context 'when created' do

    it 'has a the given label' do
      expect(subject.label).to eq('interaction label')
    end

  end

  context 'when specifying the request' do

    let(:request_attributes) { double('request attributes') }
    let(:new_request) { double('new_request') }

    before do
      allow(Shokkenki::Consumer::Request).
        to(receive(:new).with(request_attributes).and_return(new_request))
      subject.requested_with request_attributes
    end

    it 'uses the request attributes to set the request' do
      expect(subject.request).to be(new_request)
    end
  end

  context 'when specifying the response' do

    let(:response_attributes) { double('response attributes') }
    let(:new_response) { double('new_response') }

    before do
      allow(Shokkenki::Consumer::Response).
        to(receive(:new).with(response_attributes).and_return(new_response))
      subject.responds_with response_attributes
    end

    it 'uses the response attributes to set the response' do
      expect(subject.response).to be(new_response)
    end
  end

end