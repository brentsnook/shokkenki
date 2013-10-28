require_relative '../../../spec_helper'
require 'shokkenki/consumer/model/provider'
require 'shokkenki/consumer/stubber/http_stubber'

describe Shokkenki::Consumer::Model::Provider do

  let(:stubber) { double('stubber').as_null_object }

  subject { Shokkenki::Consumer::Model::Provider.new(:stubber => stubber) }

  context 'when created' do
    context 'with a stubber' do

      it 'has the stubber' do
        expect(subject.stubber).to eq(stubber)
      end
    end

    context 'without a stubber' do

      subject { Shokkenki::Consumer::Model::Provider.new(:stubber => nil) }

      let(:http_stubber) { double('http stubber') }

      before do
        allow(Shokkenki::Consumer::Stubber::HttpStubber).to receive(:new).and_return http_stubber
      end

      it 'has a new HTTP stubber' do
        expect(subject.stubber).to eq(http_stubber)
      end

    end
  end

  context 'stubbing an interaction' do

    subject { Shokkenki::Consumer::Model::Provider.new(:stubber => stubber) }

    let(:interaction) { double('interaction').as_null_object }

    before do
      subject.stub_interaction interaction
    end

    it 'uses its stubber' do
      expect(stubber).to have_received(:stub_interaction).with(interaction)
    end
  end

  context 'clearing interaction stubs' do

    subject { Shokkenki::Consumer::Model::Provider.new(:stubber => stubber) }

    before do
      subject.clear_interaction_stubs
    end

    it 'clears interaction stubs on its stubber' do
      expect(stubber).to have_received(:clear_interaction_stubs)
    end
  end

  context 'when the session starts' do

    before { subject.session_started }

    it 'notifies its stubber of the session start' do
      expect(stubber).to have_received(:session_started)
    end
  end

  context 'when the session closes' do

    before { subject.session_closed }

    it 'notifies its stubber of the session close' do
      expect(stubber).to have_received(:session_closed)
    end
  end
end
