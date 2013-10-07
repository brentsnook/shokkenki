require_relative '../../spec_helper'
require 'shokkenki/consumer/ticket'
require 'json'
require 'shokkenki/version'

describe Shokkenki::Consumer::Ticket do

  let(:interaction) { double('interaction') }
  let(:time) { Time.now }

  before do
    stub_const('Shokkenki::Version::STRING', '99.9')
  end

  subject do
    Shokkenki::Consumer::Ticket.new(
      :provider => 'providertron',
      :consumer => 'consumertron',
      :interactions => [interaction]
    )
  end

  context 'when created' do

    it 'has the consumer it is given' do
      expect(subject.consumer).to eq('consumertron')
    end

    it 'has the provider it is given' do
      expect(subject.provider).to eq('providertron')
    end

    it 'has the interactions it is given' do
      expect(subject.interactions).to eq([interaction])
    end

  end

  describe 'filename' do

    it 'contains the consumer and provider names' do
      expect(subject.filename).to match(/consumertron-providertron/)
    end

    it 'has a JSON extension' do
      expect(subject.filename).to match(/\.json$/)
    end
  end

  context 'converted to JSON' do

    before do
      allow(interaction).to receive(:to_hash).and_return({:interaction => :json})
    end

    let(:json) { JSON.parse subject.to_json }

    it 'includes the consumer' do
      expect(json['consumer']['name']).to eq('consumertron')
    end

    it 'includes the provider' do
      expect(json['provider']['name']).to eq('providertron')
    end

    it 'includes the version' do
      expect(json['version']).to eq('99.9')
    end

    it 'includes the JSON of each interaction' do
      expect(json['interactions']).to eq([{'interaction' => 'json'}])
    end
  end
end