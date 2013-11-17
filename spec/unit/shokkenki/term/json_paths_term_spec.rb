require_relative '../../spec_helper'
require 'shokkenki/term/json_paths_term'
require 'shokkenki/term/json_path_example'
require 'shokkenki/term/term_factory'

describe Shokkenki::Term::JsonPathsTerm do

  let(:child_term) { double 'child term' }

  context 'when created' do
    let(:termable) { double 'termable', :to_shokkenki_term => 'shokkenki term'}
    let(:values) { {'$.thing' => termable} }

    subject { Shokkenki::Term::JsonPathsTerm.new values }

    it "has a type of 'json_paths'" do
      expect(subject.type).to eq(:json_paths)
    end

    it 'forces each value to be a shokkenki term' do
      expect(subject.values).to eq('$.thing' => 'shokkenki term')
    end
  end

  context 'created from json' do
    let(:term) do
      Shokkenki::Term::JsonPathsTerm.from_json(
        'values' => {'$.thing' => {'childterm' => 'json'}}
      )
    end

    before do
      allow(Shokkenki::Term::TermFactory).to(
        receive(:from_json).with({'childterm' => 'json'}).and_return double('termable', :to_shokkenki_term => child_term)
      )
    end

    it 'creates terms for each of its values' do
      expect(term.values).to eq('$.thing' => child_term)
    end
  end

  context 'matching a compare' do
    let(:child1) { double 'child1'}
    let(:child2) { double 'child2'}

    subject do
      Shokkenki::Term::JsonPathsTerm.new(
        '$.child1' => double('child 1 termable', :to_shokkenki_term => child1),
        '$.child2' => double('child 2 termable', :to_shokkenki_term => child2)
      )
    end

    context 'when some values of the compare match' do
      before do
        allow(child1).to receive(:match?).with(['child 1 value']).and_return true
        allow(child2).to receive(:match?).with(['child 2 value']).and_return false
      end

      let(:compare) { {:child1 => 'child 1 value', :child2 => 'child 2 value'}.to_json }
      it("doesn't match"){ expect(subject.match?(compare)).to be_false }
    end

    context 'when all values of the compare match' do
      before do
        allow(child1).to receive(:match?).with(['child 1 value']).and_return true
        allow(child2).to receive(:match?).with(['child 2 value']).and_return true
      end

      let(:compare) { {:child1 => 'child 1 value', :child2 => 'child 2 value'}.to_json }
      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when the compare matches but has more values' do
      before do
        allow(child1).to receive(:match?).with(['child 1 value']).and_return true
        allow(child2).to receive(:match?).with(['child 2 value']).and_return true
      end

      let(:compare) do
        {
          :child1 => 'child 1 value',
          :child2 => 'child 2 value',
          :child3 => 'child value 3'
        }.to_json
      end

      it('matches'){ expect(subject.match?(compare)).to be_true }
    end

    context 'when there is no compare' do
      it("doesn't match"){ expect(subject.match?(nil)).to be_false }
    end
  end

  context 'generating an example' do
    let(:term) do
      Shokkenki::Term::JsonPathsTerm.new(
        '$.path.to.first.child' => double('term 1', :to_shokkenki_term =>first_child_term),
        '$.path.to.second.child' => double('term 2', :to_shokkenki_term =>second_child_term)
      )
    end

    let(:first_example) do
      double('first example',
        :to_example => {
          :path => {
            :to => {
              :first => {
                :child => 'first child example'
              }
            }
          }
        }
      )
    end

    let(:second_example) do
      double('second example',
        :to_example => {
          :path => {
            :to => {
              :second => {
                :child => 'second child example'
              }
            }
          }
        }
      )
    end

    before do
      allow(Shokkenki::Term::JsonPathExample).to(
        receive(:new).with('$.path.to.first.child', first_child_term).and_return(first_example)
      )

      allow(Shokkenki::Term::JsonPathExample).to(
        receive(:new).with('$.path.to.second.child', second_child_term).and_return(second_example)
      )
    end

    let(:first_child_term) { double 'first child' }
    let(:second_child_term) { double 'second child' }

    it 'generates a combined JSON string containing an example for each value' do
      expect(term.example).to eq(
        {
          :path => {
            :to => {
              :first => {
                :child => 'first child example'
              },
              :second => {
                :child => 'second child example'
              }
            }
          }
        }.to_json
      )
    end
  end

  context 'as a hash' do
    let(:value) { double('value', :to_hash => {:hashed => :apples}) }

    subject do
      Shokkenki::Term::JsonPathsTerm.new(
        '$.key' => double('termable', :to_shokkenki_term => value )
      )
    end

    it 'has a type' do
      expect(subject.to_hash[:type]).to eq(:json_paths)
    end

    it 'converts all values to a hash' do
      expect(subject.to_hash[:values]).to(eq(
        '$.key' => {:hashed => :apples}
      ))
    end
  end
end