require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/unmatched_requests_middleware'
require 'shokkenki/consumer/stubber/interaction'

describe Shokkenki::Consumer::Stubber::UnmatchedRequestsMiddleware do
  let(:interactions) { double('interactions').as_null_object }
  let(:call_response) { subject.call env }

  subject { Shokkenki::Consumer::Stubber::UnmatchedRequestsMiddleware.new interactions }

  context 'retrieving unmatched HTTP requests' do
    let(:env) do
      {
        'REQUEST_METHOD' => 'GET'
      }
    end

    let(:request) { double('request', :to_hash => {:request => 'json'}).as_null_object }

    before do
      allow(interactions).to receive(:unmatched_requests).and_return([request])
    end

    it 'renders all interaction requests as pretty printed JSON' do
      json = <<-JSON
[
  {
    "request": "json"
  }
]
JSON
      expect(call_response[2]).to eq([json.strip])
    end

    it 'returns a status to indicate success (200)' do
      expect(call_response[0]).to eq(200)
    end

    it 'indicates that the returned content is JSON' do
      expect(call_response[1]).to include('Content-Type' => 'application/json')
    end

  end
end