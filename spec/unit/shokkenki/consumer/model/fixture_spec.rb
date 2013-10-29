require_relative '../../../spec_helper'
require 'shokkenki/consumer/model/fixture'

describe Shokkenki::Consumer::Model::Fixture do

  context 'when created' do

    subject do
      Shokkenki::Consumer::Model::Fixture.new(
        :name => :fixture_name,
        :arguments => {:fixture => :arguments},
      )
    end

    it 'has the given name' do
      expect(subject.name).to eq(:fixture_name)
    end

    it 'has the given arguments' do
      expect(subject.arguments).to eq({:fixture => :arguments})
    end
  end

  context 'converted to a hash' do
    let(:arguments) { {:fixture => :arguments} }

    subject do
      Shokkenki::Consumer::Model::Fixture.new(
        :name => :fixture_name,
        :arguments => arguments,
      )
    end

    it 'includes the name' do
      expect(subject.to_hash[:name]).to eq(:fixture_name)
    end

    context 'when there are arguments' do
      it 'includes the arguments' do
        expect(subject.to_hash[:arguments]).to eq(:fixture => :arguments)
      end
    end

    context 'when there are no arguments' do
      let(:arguments) { nil }
      it 'does not include the arguments' do
        expect(subject.to_hash).to_not have_key(:arguments)
      end
    end
  end
end