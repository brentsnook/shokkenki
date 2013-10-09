require_relative '../../../spec_helper'
require 'shokkenki/consumer/term/and_expression_term'

describe Shokkenki::Consumer::Term::AndExpressionTerm do

  class HashableValue

    def initialize value
      @value = value
    end

    def to_hash
      @value
    end

  end

  subject { Shokkenki::Consumer::Term::AndExpressionTerm.new HashableValue.new({'forced key' => 'string value'}) }

  context 'when created' do
    it "has a type of 'and_expression'" do
      expect(subject.type).to eq(:and_expression)
    end

    it 'forces the given values into a hash' do
      expect(subject.values.keys.first).to eq('forced key')
    end

    it 'forces each of the has values into a shokkenki term' do
      expect(subject.values.values.first.type).to eq(:string)
    end
  end

  context 'as a hash' do
    let(:term_value) { double('term value', :to_hash => {:hashed => :apples}) }
    let(:value) {double('value', :to_shokkenki_term => term_value) }

    subject do
      Shokkenki::Consumer::Term::AndExpressionTerm.new(
        :key => value
      )
    end

    it 'has a type' do
      expect(subject.to_hash[:type]).to eq(:and_expression)
    end

    it 'converts all values to a hash' do
      expect(subject.to_hash[:values]).to(eq(
        :key => {:hashed => :apples}
      ))
    end
  end
end