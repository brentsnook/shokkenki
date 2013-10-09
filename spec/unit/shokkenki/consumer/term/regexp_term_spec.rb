require_relative '../../../spec_helper'
require 'shokkenki/consumer/term/regexp_term'

describe Shokkenki::Consumer::Term::RegexpTerm do
  subject { Shokkenki::Consumer::Term::RegexpTerm.new 'sausages' }

  context 'when created' do
    it "has a type of 'regexp'" do
      expect(subject.type).to eq(:regexp)
    end

    it 'forces the given value into a regexp' do
      expect(subject.value).to eq(/sausages/)
    end
  end

  context 'as a hash' do

    subject { Shokkenki::Consumer::Term::RegexpTerm.new /sausages/ }

    it 'has a type' do
      expect(subject.to_hash[:type]).to eq(:regexp)
    end

    it 'has a value that is the string representation of the regex' do
      expect(subject.to_hash[:value]).to eq('(?-mix:sausages)')
    end
  end
end