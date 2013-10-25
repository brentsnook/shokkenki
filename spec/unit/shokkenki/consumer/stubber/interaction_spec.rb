require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/interaction'
require 'shokkenki/term/term_factory'

describe Shokkenki::Consumer::Stubber::Interaction do
  context 'created from json' do

    subject { Shokkenki::Consumer::Stubber::Interaction }
    let(:interaction) { subject.from_json json }
    let(:json) do
      {
        'label' => 'my lovely interaction',
        'time' => '3pm',
        'request' => { 'request' => 'json' },
        'response' => { 'response' => 'json' }
      }
    end
    let(:request_term) { double 'request term' }
    let(:response_term) { double 'response term' }

    before do
      allow(Shokkenki::Term::TermFactory).to receive(:from_json).with({ 'request' => 'json' }).and_return request_term
      allow(Shokkenki::Term::TermFactory).to receive(:from_json).with({ 'response' => 'json' }).and_return response_term
    end

    it 'sets the label' do
      expect(interaction.label).to eq('my lovely interaction')
    end

    it 'sets the time' do
      expect(interaction.time).to eq('3pm')
    end

    it 'parses the request as a term' do
      expect(interaction.request).to eq(request_term)
    end

    it 'parses the request as a term' do
      expect(interaction.response).to eq(response_term)
    end
  end

  context 'generating a response' do

    subject do
      Shokkenki::Consumer::Stubber::Interaction.new(
        :response => response
      )
    end

    let(:response) { double 'response' }

    before do
      allow(response).to receive(:example).and_return('generated response')
    end

    it 'uses the response term example' do
      expect(subject.generate_response).to eq('generated response')
    end
  end

  context 'matching a request' do

    subject do
      Shokkenki::Consumer::Stubber::Interaction.new(
        :request => request
      )
    end

    let(:request) { double('request').as_null_object }

    before { subject.match_request? request }

    it 'uses the request term' do
      expect(request).to have_received(:match?).with(request)
    end
  end

end