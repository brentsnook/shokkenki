require_relative '../../spec_helper'
require 'shokkenki/provider/model/ticket'

describe 'RSpec' do
  context 'when required' do
    before do
      load 'shokkenki/provider/rspec.rb'
    end

    it 'allows a ticket to verify its self with a provider' do
      expect(Shokkenki::Provider::Model::Ticket.new).to respond_to(:verify_with)
    end
  end
end