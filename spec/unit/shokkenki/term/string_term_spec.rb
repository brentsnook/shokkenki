require_relative '../../spec_helper'
require 'shokkenki/term/string_term'

describe Shokkenki::Term::StringTerm do

  context 'created from json' do
    let(:term) do
      Shokkenki::Term::StringTerm.from_json(
        'value' => 'some value'
      )
    end

    it 'has the value' do
      expect(term.value).to eq('some value')
    end
  end

  context 'generating an example' do
    subject do
      Shokkenki::Term::StringTerm.new :value => 'some value'
    end

    it 'uses the exact value' do
      expect(subject.example).to eq('some value')
    end
  end

  context 'matching a compare' do
    subject do
      Shokkenki::Term::StringTerm.new :value => 'some value'
    end

    context 'when the compare is the same' do
      let(:compare) { 'some value' }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when the compare is not the same' do
      let(:compare) { 'some different value' }
      it("doesn't match"){ expect(subject.match?(compare)).to be_false }
    end

    context 'when there is no compare' do
      let(:compare) { nil }
      it("doesn't match"){ expect(subject.match?(compare)).to be_false }
    end

    context 'when the compare is the same but contains surrounding whitespace' do
      let(:compare) { "  some value   \t" }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end
  end
end