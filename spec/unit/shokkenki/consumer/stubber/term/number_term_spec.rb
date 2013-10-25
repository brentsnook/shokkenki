require_relative '../../../../spec_helper'
require 'shokkenki/consumer/stubber/term/number_term'

describe Shokkenki::Consumer::Stubber::Term::NumberTerm do

  context 'created from json' do
    let(:term) do
      Shokkenki::Consumer::Stubber::Term::NumberTerm.from_json(
        'value' => 9
      )
    end

    it 'has the value' do
      expect(term.value).to eq(9)
    end
  end

  context 'generating an example' do
    subject do
      Shokkenki::Consumer::Stubber::Term::NumberTerm.new :value => 9
    end

    it 'uses the exact value' do
      expect(subject.example).to eq(9)
    end
  end

  context 'matching a compare' do
    subject do
      Shokkenki::Consumer::Stubber::Term::NumberTerm.new :value => 9
    end

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
end