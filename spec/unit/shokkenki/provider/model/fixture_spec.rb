require_relative '../../../spec_helper'
require 'shokkenki/provider/model/fixture'

describe Shokkenki::Provider::Model::Fixture do

  let(:establisher) { double(:establisher, :arity => 0).as_null_object }
  subject { Shokkenki::Provider::Model::Fixture.new name_pattern, establisher }

  context 'when created' do
    it 'asserts that the establisher has an arity of 0 or 1 only' do
      message = 'Fixture establisher for name pattern /(?-mix:name)/ must only accept zero or one argument.'
      expect{Shokkenki::Provider::Model::Fixture.new(/name/, lambda{|first, second| })}.to raise_error(message)
    end
  end
  context 'being established' do

    context 'when the required fixture matches the name pattern' do
      let(:required_fixture) do
        double(:required_fixture,
          :name => 'match',
          :arguments => :fixture_arguments
        )
      end

      let(:name_pattern) { /match/ }

      context 'when the establisher accepts no arguments' do
        before { subject.establish required_fixture }
        it 'calls the establisher' do
          expect(establisher).to have_received(:call)
        end
      end

      context 'when the establisher accepts a single argument' do
        before { subject.establish required_fixture }
        let(:establisher) { double(:establisher, :arity => 1).as_null_object }

        it 'passes the establisher required fixture arguments' do
          expect(establisher).to(
            have_received(:call).with(hash_including(:arguments => :fixture_arguments))
          )
        end

        it 'passes the establisher the name match' do
          expect(establisher).to(
            have_received(:call).with(hash_including(:match => /match/.match('match')))
          )
        end
      end

    end
  end

  context "when the required fixture doesn't match" do

    let(:required_fixture) do
      double(:required_fixture,
        :name => 'match',
        :arguments => :fixture_arguments
      )
    end

    let(:name_pattern) { /miss/ }

    it "doesn't call the fixture" do
      expect(establisher).to_not have_received(:call)
    end
  end

end