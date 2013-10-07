require_relative '../../spec_helper'
require 'timecop'
require 'shokkenki/consumer/interaction'
require 'shokkenki/consumer/request'
require 'shokkenki/consumer/response'

describe Shokkenki::Consumer::Interaction do

  context 'when created' do

    let(:request) { double 'request' }
    let(:response) { double 'response' }
    let(:current_time) { Time.now }

    subject do
      Timecop.freeze(current_time) do
        Shokkenki::Consumer::Interaction.new(
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

end