require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/rack_server'
require 'shokkenki/consumer/stubber/admin_middleware'
require 'shokkenki/consumer/stubber/stubbed_response_middleware'

describe Shokkenki::Consumer::Stubber::RackServer do
  let(:call) { subject.call env }
  let(:admin_middleware) { double 'admin middleware', :call => 'admin middleware' }
  let(:stubbed_response_middleware) { double 'stubbed response middleware', :call => 'stubbed response middleware' }

  subject { Shokkenki::Consumer::Stubber::RackServer.new }

  before do
    allow(Shokkenki::Consumer::Stubber::AdminMiddleware).to receive(:new).and_return admin_middleware
    allow(Shokkenki::Consumer::Stubber::StubbedResponseMiddleware).to receive(:new).and_return stubbed_response_middleware
  end

  context 'responding to shokkenki admin requests' do
    let(:env) { {'PATH_INFO' => '/shokkenki/some_admin_action'} }
    it 'uses the admin middleware to process the request' do
      expect(call).to eq('admin middleware')
    end
  end

  context 'responding to other requests' do
    let(:env) { {'PATH_INFO' => '/some_other_request'} }
    it 'uses the stubbed response middleware to handle the request' do
      expect(call).to eq('stubbed response middleware')
    end
  end
end