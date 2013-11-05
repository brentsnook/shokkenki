require_relative '../../../spec_helper'
require 'shokkenki/consumer/consumer'
require 'shokkenki/consumer/rspec/example_group_binding'

describe Shokkenki::Consumer::RSpec::ExampleGroupBinding do

  class BoundExampleGroup
    include Shokkenki::Consumer::RSpec::ExampleGroupBinding
  end

  let(:bound_example_group) do
    BoundExampleGroup.new
  end

  # this is the entry point for the DSL
  it "makes the consumer session available as 'shokkenki'" do
    expect(bound_example_group.shokkenki).to be(Shokkenki.consumer)
  end

  context 'order' do
    let(:order) { double 'order' }

    before do
      allow(Shokkenki.consumer).to receive(:order).with(:provider).and_return order
    end

    it 'creates an order on the consumer session' do
      expect(bound_example_group.order(:provider)).to eq(order)
    end
  end
end
