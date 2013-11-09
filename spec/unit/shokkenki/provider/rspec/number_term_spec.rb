require_relative '../../../spec_helper'
require 'shokkenki/provider/rspec/number_term'

describe Shokkenki::Provider::RSpec::NumberTerm do
  class NumberTermStub
    include Shokkenki::Provider::RSpec::NumberTerm
  end

  subject { NumberTermStub.new }

  context 'verifying within a context' do
    let(:example_context) do
      double('example context',
        :expect => expectation,
        :actual_value => 28,
        :eq => matcher
      ).as_null_object
    end

    let(:matcher) { double 'matcher' }
    let(:expectation) { double('expectation', :to => '') }

    before do
      allow(subject).to receive(:value).and_return(99)
      allow(example_context).to receive(:it) do |&block|
        example_context.instance_eval &block
      end

      subject.verify_within example_context
    end

    it 'names the assertion using the value of the term' do
      expect(example_context).to have_received(:it).with('is 99')
    end

    it 'asserts that the actual value is the same as the term value' do
      expect(example_context).to have_received(:expect).with(28)
      expect(expectation).to have_received(:to)
      expect(example_context).to have_received(:eq).with(99)
    end

  end
end