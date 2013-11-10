require_relative '../../../spec_helper'
require 'shokkenki/provider/rspec/regexp_term'

describe Shokkenki::Provider::RSpec::RegexpTerm do
  class RegexpTermStub
    include Shokkenki::Provider::RSpec::RegexpTerm
  end

  subject { RegexpTermStub.new }

  context 'verifying within a context' do
    let(:example_context) do
      double('example context',
        :expect => expectation,
        :match => matcher
      ).as_null_object
    end

    let(:matcher) { double 'matcher' }
    let(:expectation) { double('expectation', :to => '') }

    before do
      example_context.instance_eval { @actual_value = 9 }
      allow(subject).to receive(:value).and_return(/99 problems/)
      allow(example_context).to receive(:it) do |&block|
        example_context.instance_eval &block
      end

      subject.verify_within example_context
    end

    it 'names the assertion using the value of the term, including the extra crap from Regexp.to_s' do
      expect(example_context).to have_received(:it).with('matches /(?-mix:99 problems)/')
    end

    # stubtastic - can't think of a better way to test this though
    it 'asserts that the actual value as a string is the same as the term value' do
      expect(example_context).to have_received(:expect).with('9')
      expect(expectation).to have_received(:to)
      expect(example_context).to have_received(:match).with(/99 problems/)
    end

  end
end