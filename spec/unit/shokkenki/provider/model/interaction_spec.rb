require_relative '../../../spec_helper'
require 'shokkenki/provider/model/interaction'
require 'shokkenki/term/term_factory'

describe Shokkenki::Provider::Model::Interaction do
  context 'created from a hash' do
    let(:request) { double 'request' }
    let(:response) { double 'response' }
    let(:request_hash) { {:request => ''} }
    let(:response_hash) { {:response => ''} }

    before do
      allow(Shokkenki::Term::TermFactory).to receive(:from_json).with(request_hash).and_return(request)
      allow(Shokkenki::Term::TermFactory).to receive(:from_json).with(response_hash).and_return(response)
    end

    let(:interaction) do
      Shokkenki::Provider::Model::Interaction.from_hash(
        :request => request_hash,
        :response => response_hash,
        :label => 'label'
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
  end
end