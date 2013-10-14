require_relative '../../../spec_helper'
require 'httparty'
require 'shokkenki/consumer/stubber/http_stubber'

describe Shokkenki::Consumer::Stubber::HttpStubber do

  let(:interaction) { double('interaction').as_null_object }

  let(:interactions_url) { 'http://stubby.com:1235/interactions' }

  subject do
    Shokkenki::Consumer::Stubber::HttpStubber.new(
      :interactions_url => interactions_url
    )
  end

  before do
    allow(interaction).to receive(:to_hash).and_return({:interaction => 'hash'})
  end

  context 'when created' do

    it 'has the interactions URL provided' do
      expect(subject.interactions_url).to eq('http://stubby.com:1235/interactions')
    end

    context 'when the interactions URL is not a valid URL' do

      subject do
        Shokkenki::Consumer::Stubber::HttpStubber.new(
          :interactions_url =>'hzzp:\rubbishurl'
        )
      end

      it 'fails' do
        expect{ subject.interactions_url }.to raise_error(/bad URI/)
      end
    end

  end

  context 'stubbing an interaction' do

    before do
      allow(HTTParty).to receive(:post).and_return response
    end

    context 'when the request succeeds' do

      let(:response) { double('response', :code => 200) }

      it 'posts the interaction to the interactions collection' do
        subject.stub_interaction interaction
        expect(HTTParty).to have_received(:post).with(
          interactions_url,
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
    end

    context 'when the request succeeds' do

      let(:response) { double('response', :code => 200) }

      it 'deletes the entire interactions collection' do
        subject.clear_interaction_stubs
        expect(HTTParty).to have_received(:delete).with(
          interactions_url
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
end