require_relative '../../../spec_helper'
require 'shokkenki/consumer/model/provider'
require 'shokkenki/consumer/stubber/null_stubber'

describe Shokkenki::Consumer::Model::Provider do

  let(:stubber) { double('stubber').as_null_object }

  context 'when created' do
    context 'with a stubber' do

      subject { Shokkenki::Consumer::Model::Provider.new(:stubber => stubber) }

      it 'has the stubber' do
        expect(subject.stubber).to eq(stubber)
      end
    end

    context 'without a stubber' do

      subject { Shokkenki::Consumer::Model::Provider.new(:stubber => nil) }

      let(:null_stubber) { double('null stubber') }

      before do
        allow(Shokkenki::Consumer::Stubber::NullStubber).to receive(:new).and_return null_stubber
      end

      it 'has a new null stubber' do
        expect(subject.stubber).to eq(null_stubber)
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
end
