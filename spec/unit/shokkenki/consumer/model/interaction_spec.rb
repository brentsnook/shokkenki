require_relative '../../../spec_helper'
require 'timecop'
require 'shokkenki/consumer/model/interaction'

describe Shokkenki::Consumer::Model::Interaction do

  context 'when created' do

    let(:request) { double 'request' }
    let(:response) { double 'response' }
    let(:current_time) { Time.now }

    subject do
      Timecop.freeze(current_time) do
        Shokkenki::Consumer::Model::Interaction.new(
          :label => 'interaction label',
          :request => request,
          :response => response
        )
      end
    end

    it 'has a the given label' do
      expect(subject.label).to eq('interaction label')
    end

    it 'has the given request' do
      expect(subject.request).to eq(request)
    end

    it 'has the given response' do
      expect(subject.response).to eq(response)
    end

    it 'has the current time' do
      expect(subject.time).to eq(current_time)
    end
  end

  context 'converted to a hash' do
    let(:request) { double 'request', :to_hash => {'request' => 'hash'} }
    let(:response) { double 'response', :to_hash => {'response' => 'hash'}  }
    let(:current_time) { Time.parse '2012-04-23T18:25:43Z' }

    let(:label) { 'interaction label' }
    subject do
      Timecop.freeze(current_time) do
        Shokkenki::Consumer::Model::Interaction.new(
          :label => label,
          :request => request,
          :response => response
        )
      end
    end

    context 'when there is a label' do
      it 'includes the label' do
        expect(subject.to_hash[:label]).to eq('interaction label')
      end
    end

    context 'when there is no label' do
      let(:label) { nil }
      it 'does not include the label' do
        expect(subject.to_hash).to_not have_key(:label)
      end
    end

    it 'includes the request hash' do
      expect(subject.to_hash[:request]).to eq({'request' => 'hash'})
    end

    it 'includes the response hash' do
      expect(subject.to_hash[:response]).to eq({'response' => 'hash'})
    end

    it 'includes the time formatted as an ISO 8601 date' do
      expect(subject.to_hash[:time]).to eq('2012-04-23T18:25:43Z')
    end
  end

end