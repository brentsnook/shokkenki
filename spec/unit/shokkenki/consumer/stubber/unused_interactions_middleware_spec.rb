require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/unused_interactions_middleware'

describe Shokkenki::Consumer::Stubber::UnusedInteractionsMiddleware do
  let(:interactions) { double('interactions').as_null_object }
  let(:call_response) { subject.call env }

  subject { Shokkenki::Consumer::Stubber::UnusedInteractionsMiddleware.new interactions }

  context 'retrieving unused interactions' do
    let(:env) do
      {
        'REQUEST_METHOD' => 'GET'
      }
    end

    let(:interaction) { double('interaction', :to_hash => {:interaction => 'json'}).as_null_object }

    before do
      allow(interactions).to receive(:unused_interactions).and_return([interaction])
    end

    it 'renders all interactions as pretty printed JSON' do
      json = <<-JSON
[
  {
    "interaction": "json"
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