require_relative '../../../../spec_helper'
require 'shokkenki/consumer/stubber/term/regexp_term'

describe Shokkenki::Consumer::Stubber::Term::RegexpTerm do

  context 'created from json' do
    it 'has the value'
  end

  context 'generating an example' do
    it 'generates a random string from the value pattern'
  end

  context 'matching a compare' do
    subject do
      Shokkenki::Consumer::Stubber::Term::StringTerm.new :value => 'some value'
    end

    context 'when the compare matches the value pattern' do
      it 'matches'
    end

    context 'when the compare does not match the value pattern' do
      it "doesn't match"
    end

    context 'when there is no compare' do
      it "doesn't match"
    end
  end
end