require_relative '../../../../spec_helper'
require 'shokkenki/provider/rspec/term/and_expression_term'

describe Shokkenki::Provider::RSpec::Term::AndExpressionTerm do
  class AndExprStub
    include Shokkenki::Provider::RSpec::Term::AndExpressionTerm
  end

  subject { AndExprStub.new }

  context 'verifying within a context' do
    let(:example_context) { double('example context').as_null_object }

    let(:term) { double('term').as_null_object }

    before do
      example_context.instance_eval { @actual_values = {:value_name => 'value1'} }
      allow(example_context).to receive(:describe) do |&block|
        example_context.instance_eval &block
      end
      allow(subject).to receive(:values).and_return(:value_name => term)
      allow(example_context).to receive(:before) do |&block|
        example_context.instance_eval &block
      end
      subject.verify_within example_context
    end

    it 'describes each value' do
      expect(example_context).to have_received(:describe).with(:value_name)
    end

    it 'verifies each term within the current context' do
      expect(term).to have_received(:verify_within).with(example_context)
    end

    it 'exposes the actual value as the matching value from actual values' do
      expect(example_context.instance_variable_get(:@actual_value)).to eq('value1')
    end
  end
end