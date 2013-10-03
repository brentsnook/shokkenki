require_relative '../../spec_helper'
require 'shokkenki/consumer/ticket'
require 'json'
require 'time'

describe Shokkenki::Consumer::Ticket do

  subject { Shokkenki::Consumer::Ticket.new :provider => 'providertron', :consumer => 'consumertron'}

  context 'when created' do

    it 'has the consumer it is given' do
      expect(subject.consumer). to eq('consumertron')
    end

    it 'has the provider it is given' do
      expect(subject.provider). to eq('providertron')
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
      subject.version = '99.9'
      subject.time = Time.parse '2012-04-23T18:25:43Z'
    end

    let(:json) { JSON.parse subject.to_json }

    it 'includes the consumer' do
      expect(json['consumer']['name']).to eq('consumertron')
    end

    it 'includes the provider' do
      expect(json['provider']['name']).to eq('providertron')
    end

    it 'includes the time formatted as an ISO 8601 date' do
      expect(json['time']).to eq('2012-04-23T18:25:43Z')
    end

    it 'includes the version' do
      expect(json['version']).to eq('99.9')
    end
  end
end