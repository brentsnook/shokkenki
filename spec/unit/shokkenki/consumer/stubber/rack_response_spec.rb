require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/rack_response'

describe Shokkenki::Consumer::Stubber::RackResponse do

  context 'created from an interaction' do

    let(:interaction) { double('interaction', :generate_response => response)}

    let(:response) do
      {
        :headers => { :'date' => 'Fri, 18 Oct 2013 03:32:00 GMT'},
        :body => 'the body',
        :status => 200
      }
    end

    let(:rack_response) {
      Shokkenki::Consumer::Stubber::RackResponse.from_interaction interaction
    }

    it 'has the headers' do
      expect(rack_response[1]).to eq({'Date' => 'Fri, 18 Oct 2013 03:32:00 GMT'})
    end

    it 'has the status' do
      expect(rack_response[0]).to eq(200)
    end

    it 'has the body' do
      expect(rack_response[2]).to eq(['the body'])
    end
  end

  describe 'header' do

    subject { Shokkenki::Consumer::Stubber::RackResponse }

    it 'has a string key' do
      expect(subject.as_rack_headers({:'Date' => 'some date'})).to eq('Date' => 'some date')
    end

    it 'has a camel cased key' do
      expect(subject.as_rack_headers({:'content-type' => 'text/html'})).to eq('Content-Type' => 'text/html')
    end

    it 'always has a string value' do
      expect(subject.as_rack_headers({'Date' => :tomorrow})).to eq('Date' => 'tomorrow')
    end

  end

end