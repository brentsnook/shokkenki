require_relative '../../../spec_helper'
require 'shokkenki/consumer/dsl/session'
require 'shokkenki/consumer/dsl/order'

describe Shokkenki::Consumer::DSL::Session do

  class StubSession
    include Shokkenki::Consumer::DSL::Session
  end

  subject { StubSession.new }

  context 'ordering' do

    let(:order) { double('order').as_null_object }
    let(:patronage) { double('patronage').as_null_object }
    let(:interaction) { double('interaction').as_null_object }

    before do
      allow(Shokkenki::Consumer::DSL::Order).to receive(:new).and_return order
      allow(order).to receive(:provider_name).and_return(:provider_name)
      allow(subject).to receive(:provider).with(:provider_name).and_return patronage
      allow(order).to receive(:to_interaction).and_return interaction
      subject.order do
        set_some_details
      end
    end

    it 'allows the details of the order to be collected' do
      expect(order).to have_received(:set_some_details)
    end

    it 'creates a new interaction for the patronage of the named provider and current consumer' do
      expect(patronage).to have_received(:add_interaction).with interaction
    end
  end
end