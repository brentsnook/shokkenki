require_relative '../../spec_helper'
require 'shokkenki/provider/model/ticket'
require 'shokkenki/provider/model/interaction'

require 'shokkenki/term/and_expression_term'
require 'shokkenki/term/string_term'
require 'shokkenki/term/number_term'
require 'shokkenki/term/regexp_term'

describe 'RSpec' do
  context 'when required' do
    before do
      load 'shokkenki/provider/rspec.rb'
    end

    it 'allows a ticket to verify its self with a provider' do
      expect(Shokkenki::Provider::Model::Ticket.new(nil, nil, nil)).to respond_to(:verify_with)
    end

    it 'allows an interaction to be verified within a context' do
      expect(Shokkenki::Provider::Model::Interaction.new).to respond_to(:verify_within)
    end

    context 'terms' do
      it 'allows an and expression term to be verified within a context' do
        expect(Shokkenki::Term::AndExpressionTerm.new({})).to respond_to(:verify_within)
      end

      it 'allows a number term to be verified within a context' do
        expect(Shokkenki::Term::NumberTerm.new(0)).to respond_to(:verify_within)
      end

      it 'allows a regexp term to be verified within a context' do
        expect(Shokkenki::Term::RegexpTerm.new(//)).to respond_to(:verify_within)
      end

      it 'allows a string term to be verified within a context' do
        expect(Shokkenki::Term::StringTerm.new('')).to respond_to(:verify_within)
      end

    end
  end
end