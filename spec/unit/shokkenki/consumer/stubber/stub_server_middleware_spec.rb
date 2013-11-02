require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/stub_server_middleware'
require 'shokkenki/consumer/stubber/interactions'
require 'shokkenki/consumer/stubber/interactions_middleware'
require 'shokkenki/consumer/stubber/stubbed_response_middleware'

describe Shokkenki::Consumer::Stubber::StubServerMiddleware do

  let(:call) { subject.call env }
  let(:interactions_middleware) { double 'interactions middleware', :call => 'interactions middleware' }
  let(:stubbed_response_middleware) { double 'stubbed response middleware', :call => 'stubbed response middleware' }
  let(:interactions) { double 'interactions' }

  subject { Shokkenki::Consumer::Stubber::StubServerMiddleware.new }

  before do
    allow(Shokkenki::Consumer::Stubber::Interactions).to receive(:new).and_return interactions
    allow(Shokkenki::Consumer::Stubber::InteractionsMiddleware).to receive(:new).with(interactions).and_return interactions_middleware
    allow(Shokkenki::Consumer::Stubber::StubbedResponseMiddleware).to receive(:new).with(interactions).and_return stubbed_response_middleware
  end

  context 'responding to shokkenki interactions requests' do
    let(:env) { {'PATH_INFO' => '/shokkenki/interactions'} }
    it 'uses the interactions middleware to process the request' do
      expect(call).to eq('interactions middleware')
    end
  end

  context 'responding to other requests' do
    let(:env) { {'PATH_INFO' => '/some_other_request'} }
    it 'uses the stubbed response middleware to handle the request' do
      expect(call).to eq('stubbed response middleware')
    end
  end
end