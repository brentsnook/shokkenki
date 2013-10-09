require_relative '../../../spec_helper'
require 'shokkenki/consumer/model/ticket'
require 'json'
require 'shokkenki/version'

describe Shokkenki::Consumer::Model::Ticket do

  let(:interaction) { double('interaction') }
  let(:time) { Time.now }
  let(:consumer) { double 'consumer' }
  let(:provider) { double 'provider' }

  before do
    stub_const('Shokkenki::Version::STRING', '99.9')
  end

  subject do
    Shokkenki::Consumer::Model::Ticket.new(
      :provider => provider,
      :consumer => consumer,
      :interactions => [interaction]
    )
  end

  context 'when created' do

    it 'has the consumer it is given' do
      expect(subject.consumer).to be(consumer)
    end

    it 'has the provider it is given' do
      expect(subject.provider).to be(provider)
    end

    it 'has the interactions it is given' do
      expect(subject.interactions).to eq([interaction])
    end

  end

  describe 'filename' do

    before do
      allow(consumer).to receive(:name).and_return('consumertron')
      allow(provider).to receive(:name).and_return('providertron')
    end

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
      allow(consumer).to receive(:to_hash).and_return({:name => 'consumertron'})
      allow(provider).to receive(:to_hash).and_return({:name => 'providertron'})
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