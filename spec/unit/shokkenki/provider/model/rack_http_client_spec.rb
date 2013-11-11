require_relative '../../../spec_helper'
require 'shokkenki/provider/model/rack_http_client'

describe Shokkenki::Provider::Model::RackHttpClient do

  let(:faraday_config) { double('faraday config').as_null_object }
  let(:faraday_connection) { double('faraday connection').as_null_object }
  let(:app) { double 'app' }

  before do
    allow(Faraday).to receive(:new) do |&block|
      block.call faraday_config
      faraday_connection
    end
  end

  subject { Shokkenki::Provider::Model::RackHttpClient.new app }

  context 'when created' do
    before { subject }

    it 'configures Faraday with the given Rack app' do
      expect(faraday_config).to have_received(:adapter).with(:rack, app)
    end
  end

  context 'retrieving a response for a request' do

    let(:request_term) do
      double('request term',
        :example => {
          :path => '/path',
          :method => 'get',
          :headers => ['header' => 'header value'],
          :query => ['param' => 'param value'],
          :body => 'body'
        }
      )
    end

    let(:request_config) { double('request config').as_null_object }
    let(:faraday_response) { double('faraday response').as_null_object }
    let(:response) { subject.response_for request_term }

    before do
      allow(faraday_connection).to receive(:get) do |&block|
        block.call request_config
        faraday_response
      end
    end

    describe 'faraday request' do
      before { response }

      it 'includes method' do
        expect(faraday_connection).to have_received(:get)
      end

      it 'includes path' do
        expect(request_config).to have_received(:path=).with('/path')
      end

      it 'includes headers' do
        expect(request_config).to have_received(:headers=).with(['header' => 'header value'])
      end

      it 'includes query' do
        expect(request_config).to have_received(:params=).with(['param' => 'param value'])
      end

      it 'includes body' do
        expect(request_config).to have_received(:body=).with('body')
      end
    end

    describe 'translated response' do

      let(:faraday_response) do
        Struct.new(:status, :headers, :body).
          new(200, ['response' => 'header'], 'response body')
      end

      it 'includes body' do
        expect(response[:body]).to eq('response body')
      end

      it 'includes headers' do
        expect(response[:headers]).to eq(['response' => 'header'])
      end

      it 'includes status' do
        expect(response[:status]).to eq(200)
      end
    end
  end
end