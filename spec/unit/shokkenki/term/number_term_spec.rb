require_relative '../../spec_helper'
require 'shokkenki/term/number_term'

describe Shokkenki::Term::NumberTerm do

  context 'when created' do

    subject { Shokkenki::Term::NumberTerm.new 9 }

    it "has a type of 'number'" do
      expect(subject.type).to eq(:number)
    end

    it 'uses the value as is' do
      expect(subject.value).to eq(9)
    end
  end

  context 'created from json' do
    let(:term) do
      Shokkenki::Term::NumberTerm.from_json(
        'value' => 9
      )
    end

    it 'has the value' do
      expect(term.value).to eq(9)
    end
  end

  context 'generating an example' do
    subject { Shokkenki::Term::NumberTerm.new 9 }

    it 'uses the exact value' do
      expect(subject.example).to eq(9)
    end
  end

  context 'matching a compare' do
    subject { Shokkenki::Term::NumberTerm.new 9 }

    context 'when the compare is the same' do
      let(:compare) { 9 }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when the compare is not the same' do
      let(:compare) { 8 }
      it("doesn't match"){ expect(subject.match?(compare)).to be_false }
    end

    context 'when there is no compare' do
      let(:compare) { nil }
      it("doesn't match"){ expect(subject.match?(compare)).to be_false }
    end
  end

  context 'as a hash' do
    subject { Shokkenki::Term::NumberTerm.new 9 }

    it 'has a type' do
      expect(subject.to_hash[:type]).to eq(:number)
    end

    it 'has a value' do
      expect(subject.to_hash[:value]).to eq(9)
    end
  end
end