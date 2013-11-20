require_relative '../../../../spec_helper'
require 'json'
require 'shokkenki/provider/rspec/term/json_paths_term'

describe Shokkenki::Provider::RSpec::Term::JsonPathsTerm do
  class JsonPathsTermStub
    include Shokkenki::Provider::RSpec::Term::JsonPathsTerm
  end

  subject { JsonPathsTermStub.new }

  context 'verifying within a context' do
    let(:example_context) { double('example context').as_null_object }
    let(:inner_context) { double('inner context').as_null_object }

    let(:term) { double('term').as_null_object }

    before do
      inner_context.instance_eval { @actual_value = {:first => {:second => {:third => 'value1'} } }.to_json }
      allow(example_context).to receive(:describe) do |&block|
        inner_context.instance_eval &block
      end
      allow(inner_context).to receive(:describe) do |&block|
        inner_context.instance_eval &block
      end
      allow(subject).to receive(:values).and_return('$.first.second.third' => term)
      allow(inner_context).to receive(:before).with(:each) do |&block|
        inner_context.instance_eval &block
      end

      subject.verify_within example_context
    end

    it "creates a context of 'json value'" do
      expect(example_context).to have_received(:describe).with('json value')
    end

    it "creates an inner context for each JSON path'" do
      expect(inner_context).to have_received(:describe).with('$.first.second.third')
    end

    it 'verifies each term within the inner context' do
      expect(term).to have_received(:verify_within).with(inner_context)
    end

    it 'converts actual value to the collection of values found at the given JSON path before each example runs' do
      expect(inner_context.instance_variable_get(:@actual_value)).to eq(['value1'])
    end
  end
end