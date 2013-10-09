require_relative '../../../spec_helper'
require 'shokkenki/consumer/term/string_term'

describe Shokkenki::Consumer::Term::StringTerm do
  subject { Shokkenki::Consumer::Term::StringTerm.new :somestring }

  context 'when created' do
    it "has a type of 'string'" do
      expect(subject.type).to eq(:string)
    end

    it 'forces the given value into a string' do
      expect(subject.value).to eq('somestring')
    end
  end

  context 'as a hash' do

    subject { Shokkenki::Consumer::Term::StringTerm.new 'value' }

    it 'has a type' do
      expect(subject.to_hash[:type]).to eq(:string)
    end

    it 'has a value' do
      expect(subject.to_hash[:value]).to eq('value')
    end
  end
end