require_relative '../../../spec_helper'
require 'shokkenki/provider/rspec/and_expression_term'

describe Shokkenki::Provider::RSpec::AndExpressionTerm do
  class AndExprStub
    include Shokkenki::Provider::RSpec::AndExpressionTerm
  end

  subject { AndExprStub.new }

  context 'verifying within a context' do
    let(:example_context) do
      double('example context',
        :actual_values => {:value_name => 'value1'}
      ).as_null_object
    end

    let(:term) { double('term').as_null_object }

    before do
      allow(example_context).to receive(:describe) do |&block|
        example_context.instance_eval &block
      end
      allow(subject).to receive(:values).and_return(:value_name => term)
      allow(example_context).to receive(:let) do |&block|
        @actual_value = block.call
      end
      subject.verify_within example_context
    end

    it 'describes each value' do
      expect(example_context).to have_received(:describe).with(:value_name)
    end

    it 'verifies each term within the current context' do
      expect(term).to have_received(:verify_within).with(example_context)
    end

    it 'exposes the actual value' do
      expect(example_context).to have_received(:let).with(:actual_value)
    end

    it 'exposes the actual value as the matching value from actual values' do
      expect(@actual_value).to eq('value1')
    end
  end
end