require_relative '../../../spec_helper'
require 'shokkenki/provider/configuration/provider'
require 'shokkenki/provider/model/rack_http_client'

describe Shokkenki::Provider::Configuration::Provider do

  class StubProvider
    include Shokkenki::Provider::Configuration::Provider

    attr_accessor :http_client
  end

  subject { StubProvider.new }

  context 'run' do
    let(:rack_app) { double 'rack app' }
    let(:http_client) { double 'http client' }

    before do
      allow(Shokkenki::Provider::Model::RackHttpClient).to receive(:new).with(rack_app).and_return(http_client)
      subject.run rack_app
    end

    it 'sets a new Rack http client using the given Rack app' do
      expect(subject.http_client).to be(http_client)
    end
  end

  context 'given' do
    let(:block) { lambda {} }
    before do
      allow(subject).to receive(:add_fixture)
      subject.given /pattern/, &block
    end

    it 'defines a new fixture on the provider' do
      expect(subject).to have_received(:add_fixture).with /pattern/, block
    end
  end
end