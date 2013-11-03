require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/http_stubber'
require 'shokkenki/consumer/stubber/stub_server_middleware'
require 'find_a_port'
require 'webmock/rspec'

describe Shokkenki::Consumer::Stubber::HttpStubber do

  let(:interaction) { double('interaction').as_null_object }
  let(:interactions_uri) { 'https://stubby.com:1235/interactions' }
  let(:unmatched_requests_uri) { 'https://stubby.com:1235/shokkenki/requests/unmatched' }
  let(:unused_interactions_uri) { 'https://stubby.com:1235/shokkenki/interactions/unused' }
  let(:server) { double('server').as_null_object }

  let(:default_attributes) do
    {
      :host => 'stubby.com',
      :scheme => :https,
      :port => 1235,
      :interactions_path => '/interactions'
    }
  end

  let(:attributes) { default_attributes }

  subject do
    Shokkenki::Consumer::Stubber::HttpStubber.new(attributes)
  end

  before do
    allow(interaction).to receive(:to_hash).and_return({:interaction => 'hash'})
  end

  context 'when created' do

    context 'with all values supplied' do

      it 'has the scheme provided' do
        expect(subject.scheme).to eq(:https)
      end

      it 'has the host provided' do
        expect(subject.host).to eq('stubby.com')
      end

      it 'has the port provided' do
        expect(subject.port).to eq(1235)
      end

      it 'has the interactions path provided' do
        expect(subject.interactions_path).to eq('/interactions')
      end
    end

    context 'with no scheme' do
      let(:attributes) do
        default_attributes.delete :scheme
        default_attributes
      end

      it 'defaults scheme to http' do
        expect(subject.scheme).to eq(:http)
      end
    end

    context 'with no interactions path' do
      let(:attributes) do
        default_attributes.delete :interactions_path
        default_attributes
      end
      it 'defaults interactions path to /shokkenki/interactions' do
        expect(subject.interactions_path).to eq('/shokkenki/interactions')
      end
    end

    context 'with no host' do
      let(:attributes) do
        default_attributes.delete :host
        default_attributes
      end
      it 'default the host to localhost' do
        expect(subject.host).to eq('localhost')
      end
    end

  end

  context 'stubbing an interaction' do

    let(:attributes) { default_attributes }

    before do
      stub_request(:post, /.*/).to_return(response)
      allow(subject).to receive(:server).and_return server
    end

    context 'when the request succeeds' do

      let(:response) { {:status => 200} }

      before { subject.stub_interaction interaction }

      it 'posts the interaction to the interactions collection' do
        expect(WebMock).to have_requested(:post, interactions_uri).with(
          :body => '{"interaction":"hash"}',
          :headers => {'Content-Type' => 'application/json'}
        )
      end
    end

    context 'when the request fails' do
      let(:response) { {:status => 404} }

      it 'fails with the details of the response' do
        expect{ subject.stub_interaction interaction }.to raise_error(
          /Failed to stub interaction: .*404/
        )
      end
    end

    context 'in all cases' do
      let(:response) { {:status => 200} }

      before { subject.stub_interaction interaction }

      it 'ensures that the server experienced no errors' do
        expect(server).to have_received(:assert_ok!)
      end
    end
  end

  context 'unmatched requests' do

    before do
      allow(subject).to receive(:server).and_return server
      stub_request(:get, unmatched_requests_uri).to_return(response)
    end

    context 'when the request succeeds' do

      let(:response) { {:status => 200, :body => [{'a' => 'b'}].to_json} }

      before { subject.unmatched_requests }

      it 'retrieves unmatched requests as JSON' do
        expect(subject.unmatched_requests).to eq([{'a' => 'b'}])
      end
    end

    context 'when the request fails' do
      let(:response) { {:status => 404} }

      it 'fails with the details of the response' do
        expect{ subject.unmatched_requests }.to raise_error(
          /Failed to find unmatched requests: .*404/
        )
      end
    end

    context 'in all cases' do
      let(:response) { {:status => 200, :body => [].to_json} }

      before { subject.unmatched_requests }

      it 'ensures that the server experienced no errors' do
        expect(server).to have_received(:assert_ok!)
      end
    end
  end

  context 'unused interactions' do

    before do
      allow(subject).to receive(:server).and_return server
      stub_request(:get, unused_interactions_uri).to_return(response)
    end

    context 'when the request succeeds' do

      let(:response) { {:status => 200, :body => [{'a' => 'b'}].to_json} }

      before { subject.unused_interactions }

      it 'retrieves unused interactions as JSON' do
        expect(subject.unused_interactions).to eq([{'a' => 'b'}])
      end
    end

    context 'when the request fails' do
      let(:response) { {:status => 404} }

      it 'fails with the details of the response' do
        expect{ subject.unused_interactions }.to raise_error(
          /Failed to find unused interactions: .*404/
        )
      end
    end

    context 'in all cases' do
      let(:response) { {:status => 200, :body => [].to_json} }

      before { subject.unused_interactions }

      it 'ensures that the server experienced no errors' do
        expect(server).to have_received(:assert_ok!)
      end
    end
  end

  context 'clearing interaction stubs' do

    before do
      stub_request(:delete, /.*/).to_return(response)
      allow(subject).to receive(:server).and_return server
    end

    context 'when the request succeeds' do

      let(:response) { {:status => 200} }

      it 'deletes the entire interactions collection' do
        subject.clear_interaction_stubs
        expect(WebMock).to have_requested(:delete, interactions_uri)
      end
    end

    context 'when the request fails' do
      let(:response) { {:status => 404} }

      it 'fails with the details of the response' do
        expect{ subject.clear_interaction_stubs }.to raise_error(
          /Failed to clear interaction stubs: .*404/
        )
      end
    end

    context 'in all cases' do
      let(:response) { {:status => 200} }

      before { subject.clear_interaction_stubs }

      it 'ensures that the server experienced no errors' do
        expect(server).to have_received(:assert_ok!)
      end
    end
  end

  describe 'response' do
    context 'when status is in the range of 200-299' do
      it 'is successful' do
        expect(subject.successful?(200)).to be_true
        expect(subject.successful?(250)).to be_true
        expect(subject.successful?(299)).to be_true
      end
    end

    context 'when status is outside of the range of 200-299' do
      it 'is not successful' do
        expect(subject.successful?(300)).to be_false
        expect(subject.successful?(400)).to be_false
      end
    end

  end

  context 'when the session starts' do
    let(:server) { double('server').as_null_object }
    let(:app) { double(:app) }

    before do
      allow(Shokkenki::Consumer::Stubber::Server).to receive(:new).and_return(server)
      allow(Shokkenki::Consumer::Stubber::StubServerMiddleware).to receive(:new).and_return(app)
    end

    context 'when a port has been supplied' do

      subject do
        Shokkenki::Consumer::Stubber::HttpStubber.new(:host => 'somehost', :port => 1234)
      end

      before do
        subject.session_started
      end

      it 'runs a new server on the given port' do
        expect(Shokkenki::Consumer::Stubber::Server).to have_received(:new).with(hash_including({:port => 1234}))
      end

      it 'runs a new server on the given host' do
        expect(Shokkenki::Consumer::Stubber::Server).to have_received(:new).with(hash_including({:host => 'somehost'}))
      end

      it 'runs the dummy rack app' do
        expect(Shokkenki::Consumer::Stubber::Server).to have_received(:new).with(hash_including({:app => app}))
      end

      it 'starts the newly created server' do
        expect(server).to have_received(:start)
      end
    end

    context 'when no port has been supplied' do

      subject do
        Shokkenki::Consumer::Stubber::HttpStubber.new(:port => nil)
      end

      before do
        allow(FindAPort).to receive(:available_port).and_return 9999
        subject.session_started
      end

      it 'starts the server on an available port' do
        expect(Shokkenki::Consumer::Stubber::Server).to have_received(:new).with(hash_including({:port => 9999}))
      end

      it 'allows the port to be read by specs' do
        expect(subject.port).to eq(9999)
      end
    end
  end

  context 'when the session closes' do

    let(:server) { double('server').as_null_object }

    before do
      allow(Shokkenki::Consumer::Stubber::Server).to receive(:new).and_return(server)
    end

    before do
      subject.session_started
      subject.session_closed
    end

    it 'shuts down the server' do
      expect(server).to have_received(:shutdown)
    end
  end
end