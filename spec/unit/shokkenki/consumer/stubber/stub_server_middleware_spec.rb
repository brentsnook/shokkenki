require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/stub_server_middleware'
require 'shokkenki/consumer/stubber/interactions'
require 'shokkenki/consumer/stubber/interactions_middleware'
require 'shokkenki/consumer/stubber/unused_interactions_middleware'
require 'shokkenki/consumer/stubber/stubbed_response_middleware'
require 'shokkenki/consumer/stubber/unmatched_requests_middleware'

describe Shokkenki::Consumer::Stubber::StubServerMiddleware do

  let(:call) { subject.call env }
  let(:interactions_middleware) { double 'interactions middleware', :call => 'interactions middleware' }
  let(:stubbed_response_middleware) { double 'stubbed response middleware', :call => 'stubbed response middleware' }
  let(:unmatched_requests_middleware) { double 'unmatched requests middleware', :call => 'unmatched requests middleware' }
  let(:unused_interactions_middleware) { double 'unused interactions middleware', :call => 'unused interactions middleware' }

  let(:interactions) { double 'interactions' }

  subject { Shokkenki::Consumer::Stubber::StubServerMiddleware.new }

  before do
    allow(Shokkenki::Consumer::Stubber::Interactions).to receive(:new).and_return interactions
    allow(Shokkenki::Consumer::Stubber::InteractionsMiddleware).to receive(:new).with(interactions).and_return interactions_middleware
    allow(Shokkenki::Consumer::Stubber::StubbedResponseMiddleware).to receive(:new).with(interactions).and_return stubbed_response_middleware
    allow(Shokkenki::Consumer::Stubber::UnmatchedRequestsMiddleware).to receive(:new).with(interactions).and_return unmatched_requests_middleware
    allow(Shokkenki::Consumer::Stubber::UnusedInteractionsMiddleware).to receive(:new).with(interactions).and_return unused_interactions_middleware
  end

  context 'responding to requests to identify its self' do
    let(:env) { {'PATH_INFO' => subject.identify_path} }

    it 'identifies using the object ID of the middleware' do
      expect(call[2]).to eq([subject.object_id.to_s])
    end

    it 'is successful' do
      expect(call[0]).to eq(200)
    end
  end

  context 'responding to shokkenki interactions requests' do
    let(:env) { {'PATH_INFO' => '/shokkenki/interactions'} }
    it 'uses the interactions middleware to process the request' do
      expect(call).to eq('interactions middleware')
    end
  end

  context 'responding to shokkenki unmatched HTTP request requests' do
    let(:env) { {'PATH_INFO' => '/shokkenki/requests/unmatched'} }
    it 'uses the unmatched requests middleware to process the request' do
      expect(call).to eq('unmatched requests middleware')
    end
  end

  context 'responding to shokkenki unused interactions requests' do
    let(:env) { {'PATH_INFO' => '/shokkenki/interactions/unused'} }
    it 'uses the unused interactions middleware to process the request' do
      expect(call).to eq('unused interactions middleware')
    end
  end

  context 'responding to other requests' do
    let(:env) { {'PATH_INFO' => '/some_other_request'} }
    it 'uses the stubbed response middleware to handle the request' do
      expect(call).to eq('stubbed response middleware')
    end
  end

  context 'when the request fails' do

    let(:env) { {'PATH_INFO' => '/'} }

    before do
      allow(stubbed_response_middleware).to receive(:call).and_raise('kaboom')
    end

    it 'stores the error for reference' do
      call rescue
      expect(subject.error.message).to eq('kaboom')
    end

    it 'fails' do
      expect { call }.to raise_error('kaboom')
    end

    it 'avoid clobbering existing errors' do
      subject.error = 'I was here first!'
      call rescue
      expect(subject.error).to eq('I was here first!')
    end
  end
end