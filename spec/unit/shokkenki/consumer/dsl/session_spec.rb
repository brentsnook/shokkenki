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

    before do
      allow(Shokkenki::Consumer::DSL::Order).to receive(:new).with(:provider_name, patronage).and_return order
      allow(subject).to receive(:current_patronage_for).with(:provider_name).and_return patronage
    end

    it 'creates a new order for the provider and patronage' do
      expect(subject.order(:provider_name)).to be(order)
    end
  end
end