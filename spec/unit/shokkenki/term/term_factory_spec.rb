require_relative '../../spec_helper'
require 'shokkenki/term/term_factory'

describe Shokkenki::Term::TermFactory do
  subject { Shokkenki::Term::TermFactory }
  context 'created from json' do

    let(:terminator) { double 'terminator' }
    let(:terminator_class) { double('terminator class', :from_json => terminator) }
    let(:term) do
      subject.from_json(
        'type' => 'terminator'
      )
    end

    before do
      allow(subject).to(
        receive(:factory_for).with('terminator').and_return(terminator_class)
      )
    end

    it 'creates a term as the correct type' do
      expect(term).to be(terminator)
    end
  end

  context 'finding a term factory for a type' do
    let(:factory) { double 'factory' }

    before do
      allow(subject).to(
        receive(:factories).and_return({:type => factory})
      )
    end

    context 'when the type is recognised' do
      it 'returns the factory for that type' do
        expect(subject.factory_for(:type)).to be(factory)
      end
    end

    context 'when the type is not recognised' do
      it 'fails with a message' do
        expect{ subject.factory_for(:not_recognised) }.to raise_error("Term of type 'not_recognised' is not recognised. Have you registered a factory for it?")
      end
    end

    context 'when there is no type' do
      it 'fails with a message' do
        expect{ subject.factory_for(nil) }.to raise_error('There is no term type')
      end
    end

    it 'ignores case in the type' do
      expect(subject.factory_for(:TYpe)).to be(factory)
    end
  end

  context 'registering a term factory' do

    let(:sausage_factory) { double 'sausage factory' }

    before do
      allow(subject).to(
        receive(:factories).and_return({})
      )
    end

    it 'registers the given factory for the given type' do
      subject.register(:sausage, sausage_factory)
      expect(subject.factory_for(:sausage)).to be(sausage_factory)
    end

    it 'allows a factory to be overwritten' do
      subject.register(:sausage, double('previous factory'))
      subject.register(:sausage, sausage_factory)
      expect(subject.factory_for(:sausage)).to be(sausage_factory)
    end

    it 'ignores case in term types' do
      subject.register(:SausAge, sausage_factory)
      expect(subject.factory_for(:sausage)).to be(sausage_factory)
    end

    it 'allows term types as strings' do
      subject.register('sausage', sausage_factory)
      expect(subject.factory_for(:sausage)).to be(sausage_factory)
    end

  end

  describe 'the default term factories' do
    it 'includes string' do
      expect(subject.factory_for(:string)).to_not be_nil
    end

    it 'includes and expressions' do
      expect(subject.factory_for(:and_expression)).to_not be_nil
    end

    it 'includes rexegp' do
      expect(subject.factory_for(:regexp)).to_not be_nil
    end

    it 'includes number' do
      expect(subject.factory_for(:number)).to_not be_nil
    end
  end

end