require_relative '../../../../spec_helper'
require 'shokkenki/provider/rspec/term/hash_term'

describe Shokkenki::Provider::RSpec::Term::HashTerm do
  class HashTermStub
    include Shokkenki::Provider::RSpec::Term::HashTerm
  end

  subject { HashTermStub.new }

  context 'verifying within a context' do
    let(:example_context) { double('example context').as_null_object }

    let(:term) { double('term').as_null_object }

    before do
      example_context.instance_eval { @actual_values = [{:value_name => 'value1'}] }
      allow(example_context).to receive(:describe) do |&block|
        example_context.instance_eval &block
      end
      allow(subject).to receive(:value).and_return(:value_name => term)
      allow(example_context).to receive(:before) do |&block|
        example_context.instance_eval &block
      end
      subject.verify_within example_context
    end

    it 'describes each key' do
      expect(example_context).to have_received(:describe).with(:value_name)
    end

    it 'verifies each term within the current context' do
      expect(term).to have_received(:verify_within).with(example_context)
    end

    it 'translates actual values by selecting values that match the current key' do
      expect(example_context.instance_variable_get(:@actual_values)).to eq(['value1'])
    end
  end
end