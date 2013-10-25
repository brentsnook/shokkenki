require_relative '../../../spec_helper'
require 'shokkenki/consumer/term/number_term'

describe Shokkenki::Consumer::Term::NumberTerm do
  subject { Shokkenki::Consumer::Term::NumberTerm.new 9 }

  context 'when created' do
    it "has a type of 'number'" do
      expect(subject.type).to eq(:number)
    end

    it 'uses the value as is' do
      expect(subject.value).to eq(9)
    end
  end

  context 'as a hash' do
    it 'has a type' do
      expect(subject.to_hash[:type]).to eq(:number)
    end

    it 'has a value' do
      expect(subject.to_hash[:value]).to eq(9)
    end
  end
end