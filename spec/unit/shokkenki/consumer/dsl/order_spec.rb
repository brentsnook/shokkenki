require_relative '../../../spec_helper'
require 'shokkenki/consumer/dsl/order'
require 'shokkenki/consumer/model/interaction'

describe Shokkenki::Consumer::DSL::Order do

  let(:response_attributes) { double('response attributes').as_null_object }
  let(:request_attributes) { double('request attributes').as_null_object }

  before do
    subject.provider ''
    subject.during ''
    subject.requested_with request_attributes
    subject.responds_with response_attributes
    subject.to_interaction
  end

  before do
    allow(Shokkenki::Consumer::Model::Interaction).to receive(:new)
  end

  context 'provider' do
    let(:order_with_provider) { subject.provider :providertron }

    it 'defines the provider that is being interacted with' do
      expect(order_with_provider.provider_name).to eq(:providertron)
    end

    it 'allows order calls to be chained' do
      expect(order_with_provider).to be(subject)
    end
  end

  context 'during' do
    let(:order_with_label) { subject.during 'my label' }

    it 'defines the label of the interaction' do
      order_with_label.to_interaction
      expect(Shokkenki::Consumer::Model::Interaction).to have_received(:new).with(hash_including(:label => 'my label'))
    end

    it 'allows order calls to be chained' do
      expect(order_with_label).to be(subject)
    end
  end

  context 'requested with' do

    let(:request_term) { double 'request term' }

    let(:order_with_request) { subject.requested_with request_attributes }

    before do
      allow(request_attributes).to receive(:to_shokkenki_term).and_return request_term
    end

    it 'defines the request of the interaction using a term' do
      order_with_request.to_interaction
      expect(Shokkenki::Consumer::Model::Interaction).to have_received(:new).with(hash_including(:request => request_term))
    end

    it 'allows order calls to be chained' do
      expect(order_with_request).to be(subject)
    end
  end

  context 'responds with' do

    let(:response_term) { double 'response term' }

    let(:order_with_response) { subject.responds_with response_attributes }

    before do
      allow(response_attributes).to receive(:to_shokkenki_term).and_return response_term
    end

    it 'defines the response of the interaction using a term' do
      order_with_response.to_interaction
      expect(Shokkenki::Consumer::Model::Interaction).to have_received(:new).with(hash_including(:response => response_term))
    end

    it 'allows order calls to be chained' do
      expect(order_with_response).to be(subject)
    end
  end

  context "when 'provider' has not been specified" do

    before do
      subject.provider nil
    end

    it 'fails' do
      expect { subject.validate! }.to raise_error("No 'provider' has been specified.")
    end

  end

  context 'validation' do

    context "when 'during' has not been specified" do

      before do
        subject.during nil
      end

      it 'fails' do
        expect { subject.validate! }.to raise_error("No 'during' has been specified.")
      end

    end

    context "when 'requested with' has not been specified" do

      before do
        subject.requested_with nil
      end

      it 'fails' do
        expect { subject.validate! }.to raise_error("No 'requested_with' has been specified.")
      end
    end

    context "when 'responds with' has not been specified" do

      before do
        subject.responds_with nil
      end

      it 'fails' do
        expect { subject.validate! }.to raise_error("No 'responds_with' has been specified.")
      end
    end
  end
end