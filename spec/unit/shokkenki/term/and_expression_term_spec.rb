require_relative '../../spec_helper'
require 'shokkenki/term/and_expression_term'
require 'shokkenki/term/term_factory'

describe Shokkenki::Term::AndExpressionTerm do

  let(:child_term) { double 'child term' }

  context 'created from json' do

    let(:term) do
      Shokkenki::Term::AndExpressionTerm.from_json(
        'values' => {'child' => {'childterm' => 'json'}}
      )
    end

    before do
      allow(Shokkenki::Term::TermFactory).to(
        receive(:from_json).with({'childterm' => 'json'}).and_return child_term
      )
    end

    it 'creates terms for each of its values' do
      expect(term.values).to eq(:child => child_term)
    end
  end

  context 'generating an example' do

    let(:term) do
      Shokkenki::Term::AndExpressionTerm.new(
        :child => child_term
      )
    end

    before do
      allow(child_term).to receive(:example).and_return 'child example'
    end

    it 'generates an example for each value' do
      expect(term.example).to eq({:child => 'child example'})
    end
  end

  context 'matching a compare' do

    let(:child1) { double 'child1'}
    let(:child2) { double 'child2'}

    subject do
      Shokkenki::Term::AndExpressionTerm.new(
        :child1 => child1,
        :child2 => child2
      )
    end

    context 'when some values of the compare match' do
      before do
        allow(child1).to receive(:match?).with('child 1 value').and_return true
        allow(child2).to receive(:match?).with('child 2 value').and_return false
      end

      let(:compare) { {:child1 => 'child 1 value', :child2 => 'child 2 value'} }
      it("doesn't match"){ expect(subject.match?(compare)).to be_false }
    end

    context 'when all values of the compare match' do
      before do
        allow(child1).to receive(:match?).with('child 1 value').and_return true
        allow(child2).to receive(:match?).with('child 2 value').and_return true
      end

      let(:compare) { {:child1 => 'child 1 value', :child2 => 'child 2 value'} }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when the compare matches but has more values' do
      before do
        allow(child1).to receive(:match?).with('child 1 value').and_return true
        allow(child2).to receive(:match?).with('child 2 value').and_return true
      end

      let(:compare) { {:child1 => 'child 1 value', :child2 => 'child 2 value', :child3 => 'child value 3'} }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when there is no compare' do
      it("doesn't match"){ expect(subject.match?(nil)).to be_false }
    end
  end
end