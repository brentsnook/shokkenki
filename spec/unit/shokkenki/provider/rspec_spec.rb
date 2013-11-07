require_relative '../../spec_helper'
require 'shokkenki/provider/rspec/rspec_ticket_verifier'

describe 'RSpec' do
  context 'when required' do
    let(:rspec_verifier) { double 'rspec verifier' }
    before do
      allow(Shokkenki::Provider::RSpec::RSpecTicketVerifier).to receive(:new).and_return(rspec_verifier)
      load 'shokkenki/provider/rspec.rb'
    end

    it 'uses the RSpec ticket verify to verify tickets' do
      expect(Shokkenki.provider.ticket_verifier).to be rspec_verifier
    end
  end
end