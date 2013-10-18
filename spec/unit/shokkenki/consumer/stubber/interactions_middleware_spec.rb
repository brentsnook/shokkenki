require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/interactions_middleware'
require 'shokkenki/consumer/stubber/interaction'

describe Shokkenki::Consumer::Stubber::InteractionsMiddleware do

  let(:request) { double 'request' }
  let(:interactions) { double('interactions').as_null_object }
  let(:call_response) { subject.call env }
  let(:interaction) { double 'interaction' }
  let(:rack_input) { StringIO.new('{"some":"json"}') }

  subject { Shokkenki::Consumer::Stubber::InteractionsMiddleware.new interactions }

  before do
    allow(Shokkenki::Consumer::Stubber::Interaction).to receive(:from_json).with({'some' => 'json'}).and_return(interaction)
  end

  context 'when the request is to create a new interaction' do
    let(:env) do
      {
        'REQUEST_METHOD' => 'POST',
        'rack.input' => rack_input
      }
    end

    it 'creates the new interaction' do
      call_response
      expect(interactions).to have_received(:add).with interaction
    end

    it 'returns a status to indicate success but the response contains no body (204)' do
      expect(call_response[0]).to eq(204)
    end

  end

  context 'when the request is to delete all interactions' do
    let(:env) do
      {
        'REQUEST_METHOD' => 'DELETE'
      }
    end

    it 'deletes all interactions' do
      call_response
      expect(interactions).to have_received(:delete_all)
    end

    it 'returns a status to indicate success but the response contains no body (204)' do
      expect(call_response[0]).to eq(204)
    end

  end

  context 'when the method is not recognised' do
    let(:env) do
      {
        'REQUEST_METHOD' => 'GET'
      }
    end

    it 'returns a status to indicate that the method is not allowed (405)' do
      expect(call_response[0]).to eq(405)
    end

    it 'returns a list of the allowed methods' do
      expect(call_response[1]).to include({'Allow' => ['POST', 'DELETE']})
    end

  end
end