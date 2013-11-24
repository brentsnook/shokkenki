require_relative '../../spec_helper'
require 'shokkenki/term/hash_term'
require 'shokkenki/term/term_factory'

describe Shokkenki::Term::HashTerm do

  let(:child_term) { double 'child term' }

  let(:uncoerced_child_term) do
    double 'child term', :to_shokkenki_term => child_term
  end

  context 'when created' do

    let(:values) { {:values => double('value', :to_shokkenki_term => 'value')} }

    subject { Shokkenki::Term::HashTerm.new values }

    it "has a type of 'hash'" do
      expect(subject.type).to eq(:hash)
    end

    it 'coerces the given values to a shokkenki term' do
      expect(subject.value).to eq({:values => 'value'})
    end
  end

  context 'created from json' do

    let(:term) do
      Shokkenki::Term::HashTerm.from_json(
        'value' => {'child' => {'childterm' => 'json'}}
      )
    end

    before do
      allow(Shokkenki::Term::TermFactory).to(
        receive(:from_json).with({'childterm' => 'json'}).and_return uncoerced_child_term
      )
    end

    it 'creates terms for each of its values' do
      expect(term.value).to eq(:child => child_term)
    end
  end

  context 'generating an example' do

    let(:term) do
      Shokkenki::Term::HashTerm.new(
        :child => uncoerced_child_term
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

    let(:uncoerced_child1) { double 'uncoerced child1', :to_shokkenki_term => child1 }
    let(:uncoerced_child2) { double 'uncoerced child2', :to_shokkenki_term => child2 }

    let(:child1) { double 'child1'}
    let(:child2) { double 'child2'}

    subject do
      Shokkenki::Term::HashTerm.new(
        :child1 => uncoerced_child1,
        :child2 => uncoerced_child2
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

    context 'in all cases' do
      before do
        allow(child1).to receive(:match?).with('child 1 value').and_return true
        allow(child2).to receive(:match?).with('child 2 value').and_return true
      end

      let(:compare) { double('compare', :to_hash => {:child1 => 'child 1 value', :child2 => 'child 2 value'}) }
      it('coerces the compare to a hash'){ expect(subject.match?(compare)).to be_true }
    end
  end

  context 'as a hash' do
    let(:value) { double('value', :to_hash => {:hashed => :apples}) }
    let(:uncoerced_value) { double 'uncoerced value', :to_shokkenki_term => value }

    subject do
      Shokkenki::Term::HashTerm.new(
        :key => uncoerced_value
      )
    end

    it 'has a type' do
      expect(subject.to_hash[:type]).to eq(:hash)
    end

    it 'converts all values to a hash' do
      expect(subject.to_hash[:value]).to(eq(
        :key => {:hashed => :apples}
      ))
    end
  end
end