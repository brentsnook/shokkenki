require_relative '../../../spec_helper'
require 'shokkenki/provider/model/interaction'
require 'shokkenki/provider/model/fixture_requirement'
require 'shokkenki/term/term_factory'

describe Shokkenki::Provider::Model::Interaction do
  context 'created from a hash' do
    let(:request) { double 'request' }
    let(:response) { double 'response' }
    let(:request_hash) { {:request => ''} }
    let(:response_hash) { {:response => ''} }
    let(:fixture_requirement_hash) { {:fixture_requirement => ''} }
    let(:fixture_requirement) { double 'fixture requirement' }

    before do
      allow(Shokkenki::Term::TermFactory).to receive(:from_json).with(request_hash).and_return(request)
      allow(Shokkenki::Term::TermFactory).to receive(:from_json).with(response_hash).and_return(response)
      allow(Shokkenki::Provider::Model::FixtureRequirement).to receive(:from_hash).with(fixture_requirement_hash).and_return(fixture_requirement)
    end

    let(:interaction) do
      Shokkenki::Provider::Model::Interaction.from_hash(
        :request => request_hash,
        :response => response_hash,
        :label => 'label',
        :fixtures => [fixture_requirement_hash]
      )
    end

    it 'reads the request as a term' do
      expect(interaction.request).to eq(request)
    end

    it 'reads the response as a term' do
      expect(interaction.response).to eq(response)
    end

    it 'has a label' do
      expect(interaction.label).to eq('label')
    end

    it 'creates fixture requirements from hashes' do
      expect(interaction.required_fixtures).to eq([fixture_requirement])
    end
  end
end