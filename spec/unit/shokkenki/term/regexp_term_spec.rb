require_relative '../../spec_helper'
require 'shokkenki/term/regexp_term'

describe Shokkenki::Term::RegexpTerm do
  context 'created from json' do
    let(:term) do
      Shokkenki::Term::RegexpTerm.from_json(
        'value' => 'value regex'
      )
    end

    it 'has the value' do
      expect(term.value).to eq(/value regex/)
    end
  end

  context 'generating an example' do

    subject { Shokkenki::Term::RegexpTerm.new value }

    [
      '/x/',
      '/(groups)are(cool)/',
      '/[x]{4}/',
      '/[x]{4,}/',
      '/[x]{4,10}/',
      '/[x]?/',
      '/[x]*/',
      '/[x]+/',
      '/[x]{4}middle[y]{10}/',
      '/cat|dog/',
      '/^start/',
      '/end$/',
      '/\s\S\d\D\w\W\b/',
      '/[^s]*/',
      '/[a-z]*/',
      '/some.*thing/',
      '/\Ahello/',
      '/goodbye\z/'
    ].each do |regex|
      context "with the regex #{regex}" do
        let(:value) { '/x/' }
        it 'generates a string that matches the pattern' do
          expect(subject.example).to match(subject.value)
        end
      end
    end

  end

  context 'matching a compare' do
    subject do
      Shokkenki::Term::RegexpTerm.new '9'
    end

    context 'when the compare matches the value pattern' do
      let(:compare) { 'I got 99 problems' }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when the compare as a string matches the value pattern' do
      let(:compare) { 9 }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when the compare does not match the value pattern' do
      let(:compare) { 'no match' }
      it("doesn't match"){ expect(subject.match?(compare)).to be_false }
    end

    context 'when there is no compare' do
      it("doesn't match"){ expect(subject.match?(nil)).to be_false }
    end
  end
end