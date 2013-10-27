require_relative '../../../spec_helper'
require 'shokkenki/consumer/term/and_expression_term'

describe Shokkenki::Consumer::Term::AndExpressionTerm do

  let(:values) { {:values => ''} }

  subject { Shokkenki::Consumer::Term::AndExpressionTerm.new values }

  context 'when created' do
    it "has a type of 'and_expression'" do
      expect(subject.type).to eq(:and_expression)
    end

    it 'has the given values' do
      expect(subject.values).to eq(values)
    end
  end

  context 'as a hash' do
    let(:value) { double('value', :to_hash => {:hashed => :apples}) }

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