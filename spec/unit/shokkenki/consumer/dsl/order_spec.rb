require_relative '../../../spec_helper'
require 'shokkenki/consumer/dsl/order'
require 'shokkenki/consumer/model/interaction'

describe Shokkenki::Consumer::DSL::Order do

  let(:response_attributes) { double('response attributes').as_null_object }
  let(:request_attributes) { double('request attributes').as_null_object }
  let(:patronage) { double('patronage').as_null_object }

  subject { Shokkenki::Consumer::DSL::Order.new patronage }

  before do
    subject.receive request_attributes
    subject.and_respond response_attributes
  end

  before do
    allow(Shokkenki::Consumer::Model::Interaction).to receive(:new)
  end

  context 'to' do

    let(:interaction) { double 'interaction' }

    before do
      allow(subject).to receive(:validate!)
      allow(subject).to receive(:set_details)
      allow(subject).to receive(:to_interaction).and_return interaction

      subject.to { set_details }
    end

    it 'allows the details of the order to be collected' do
      expect(subject).to have_received(:set_details)
    end

    it 'validates the order' do
      expect(subject).to have_received(:validate!)
    end

    it 'adds the resulting interaction to the patronage' do
      expect(patronage).to have_received(:add_interaction).with(interaction)
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

  context 'receive' do

    let(:request_term) { double 'request term' }

    let(:order_with_request) { subject.receive request_attributes }

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

  context 'and respond' do

    let(:response_term) { double 'response term' }

    let(:order_with_response) { subject.and_respond response_attributes }

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

  context 'validation' do

    context "when 'requested with' has not been specified" do

      before do
        subject.receive nil
      end

      it 'fails' do
        expect { subject.validate! }.to raise_error("No 'receive' has been specified.")
      end
    end

    context "when 'and respond' has not been specified" do

      before do
        subject.and_respond nil
      end

      it 'fails' do
        expect { subject.validate! }.to raise_error("No 'and_respond' has been specified.")
      end
    end
  end
end