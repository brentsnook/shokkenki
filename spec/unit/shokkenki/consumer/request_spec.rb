require_relative '../../spec_helper'
require 'shokkenki/consumer/request'

describe Shokkenki::Consumer::Request do

  context 'when created' do

    subject do
      Shokkenki::Consumer::Request.new(
        :method => :get,
        :path => '/path'
      )
    end

    it 'has the given method' do
      expect(subject.method_type).to eq(:get)
    end

    it 'has the given path' do
      expect(subject.path).to eq('/path')
    end

  end
end
