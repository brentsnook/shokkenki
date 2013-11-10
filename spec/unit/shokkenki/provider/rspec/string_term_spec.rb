require_relative '../../../spec_helper'
require 'shokkenki/provider/rspec/string_term'

describe Shokkenki::Provider::RSpec::StringTerm do
  class StringTermStub
    include Shokkenki::Provider::RSpec::StringTerm
  end

  subject { StringTermStub.new }

  context 'verifying within a context' do
    let(:example_context) do
      double('example context',
        :expect => expectation,
        :eq => matcher
      ).as_null_object
    end

    let(:matcher) { double 'matcher' }
    let(:expectation) { double('expectation', :to => '') }

    before do
      example_context.instance_eval { @actual_value = 123 }
      allow(subject).to receive(:value).and_return('value')
      allow(example_context).to receive(:it) do |&block|
        example_context.instance_eval &block
      end

      subject.verify_within example_context
    end

    it 'names the assertion using the value of the term' do
      expect(example_context).to have_received(:it).with('is "value"')
    end

    # stubtastic - can't think of a better way to test this though
    it 'asserts that the actual value as a string is the same as the term value' do
      expect(example_context).to have_received(:expect).with('123')
      expect(expectation).to have_received(:to)
      expect(example_context).to have_received(:eq).with('value')
    end

  end
end