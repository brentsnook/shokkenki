require_relative '../../../spec_helper'
require 'httparty'
require 'shokkenki/consumer/stubber/http_stubber'
require 'find_a_port'

describe Shokkenki::Consumer::Stubber::HttpStubber do

  let(:interaction) { double('interaction').as_null_object }
  let(:interactions_uri) { 'http://stubby.com/interaction_path' }

  subject do
    Shokkenki::Consumer::Stubber::HttpStubber.new({})
  end

  before do
    allow(interaction).to receive(:to_hash).and_return({:interaction => 'hash'})
  end

  context 'when created' do

    let(:default_attributes) do
      {
        :host => 'stubby.com',
        :scheme => :https,
        :port => 1235,
        :interactions_path => '/interactions'
      }
    end

    subject do
      Shokkenki::Consumer::Stubber::HttpStubber.new(attributes)
    end

    context 'with all values supplied' do
      let(:attributes) { default_attributes }

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

    before do
      allow(HTTParty).to receive(:post).and_return response
      allow(subject).to receive(:interactions_uri).and_return interactions_uri
    end

    context 'when the request succeeds' do

      let(:response) { double('response', :code => 200) }

      it 'posts the interaction to the interactions collection' do
        subject.stub_interaction interaction
        expect(HTTParty).to have_received(:post).with(
          interactions_uri,
          :body => { :interaction => 'hash' },
          :headers => {'Content-Type' => 'application/json'}
        )
      end
    end

    context 'when the request fails' do
      let(:response) { double('response', :code => 404, :inspect => 'response details') }

      it 'fails with the details of the response' do
        expect{ subject.stub_interaction interaction }.to raise_error(
          'Failed to stub interaction: response details'
        )
      end
    end
  end

  context 'clearing interaction stubs' do

    before do
      allow(HTTParty).to receive(:delete).and_return response
      allow(subject).to receive(:interactions_uri).and_return interactions_uri
    end

    context 'when the request succeeds' do

      let(:response) { double('response', :code => 200) }

      it 'deletes the entire interactions collection' do
        subject.clear_interaction_stubs
        expect(HTTParty).to have_received(:delete).with(
          interactions_uri
        )
      end
    end

    context 'when the request fails' do
      let(:response) { double('response', :code => 404, :inspect => 'response details') }

      it 'fails with the details of the response' do
        expect{ subject.clear_interaction_stubs }.to raise_error(
          'Failed to clear interaction stubs: response details'
        )
      end
    end
  end

  describe 'response' do
    context 'when code is in the range of 200-299' do
      it 'is successful' do
        expect(subject.successful?(double('response', :code => 200))).to be_true
        expect(subject.successful?(double('response', :code => 250))).to be_true
        expect(subject.successful?(double('response', :code => 299))).to be_true
      end
    end

    context 'when code is outside of the range of 200-299' do
      it 'is not successful' do
        expect(subject.successful?(double('response', :code => 300))).to be_false
        expect(subject.successful?(double('response', :code => 400))).to be_false
      end
    end

  end

  context 'when the session starts' do
    let(:server) { double('server').as_null_object }
    let(:app) { double(:app) }

    before do
      allow(Shokkenki::Consumer::Stubber::Server).to receive(:new).and_return(server)
      allow(Shokkenki::Consumer::Stubber::RackServer).to receive(:new).and_return(app)
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