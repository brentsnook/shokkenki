require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/stubbed_response_middleware'
require 'shokkenki/consumer/stubber/request'
require 'json'

describe Shokkenki::Consumer::Stubber::StubbedResponseMiddleware do

  let(:response) { double('response', :to_rack_response => rack_response) }
  let(:request) { double 'request' }
  let(:rack_response) { double 'rack response' }
  let(:interaction) { double('interaction', :response => response) }
  let(:interactions) { double('interactions').as_null_object }
  let(:env) { double 'env' }
  let(:call_response) { subject.call env }

  before do
    allow(Shokkenki::Consumer::Stubber::Request).to receive(:from_rack).with(env).and_return request
  end

  subject { Shokkenki::Consumer::Stubber::StubbedResponseMiddleware.new interactions }

  context 'when the request is recognised' do

    before do
      allow(interactions).to receive(:find).with(request).and_return interaction
    end

    it 'returns the stubbed response' do
      expect(call_response).to eq(rack_response)
    end
  end

  context 'when the request is not recognised' do
    before do
      allow(request).to receive(:to_hash).and_return( {'request' => 'hash'} )
      allow(interactions).to receive(:find).and_return nil
    end

    it 'returns a 404 status' do
      expect(call_response[0]).to eq(404)
    end

    it 'returns a message in the body stating that the request was not recognised' do
      expect(JSON.parse(call_response[2].first)).to(eq({
        'shokkenki' => {
          'message' => 'No matching responses were found for the request.',
          'request' => { 'request' => 'hash' }
        }
      }))
    end

    it 'returns the message as JSON' do
      expect(call_response[1]['Content-Type']).to eq('application/json')
    end
  end
end