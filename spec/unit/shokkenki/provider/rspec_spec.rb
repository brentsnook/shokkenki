require_relative '../../spec_helper'
require 'shokkenki/provider/model/ticket'
require 'shokkenki/provider/model/interaction'

describe 'RSpec' do
  context 'when required' do
    before do
      load 'shokkenki/provider/rspec.rb'
    end

    it 'allows a ticket to verify its self with a provider' do
      expect(Shokkenki::Provider::Model::Ticket.new).to respond_to(:verify_with)
    end

    it 'allows an interaction to be verified within a context' do
      expect(Shokkenki::Provider::Model::Interaction.new).to respond_to(:verify_within)
    end
  end
end