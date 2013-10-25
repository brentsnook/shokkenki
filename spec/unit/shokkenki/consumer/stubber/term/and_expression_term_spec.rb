require_relative '../../../../spec_helper'
require 'shokkenki/consumer/stubber/term/and_expression_term'

describe Shokkenki::Consumer::Stubber::Term::AndExpressionTerm do

  context 'created from json' do
    it 'creates terms for each of its values'
  end

  context 'generating an example' do
    it 'generates an examples for each value'
  end

  context 'matching a compare' do
    it 'matches when all values of the term match the values of the compare'
  end
end