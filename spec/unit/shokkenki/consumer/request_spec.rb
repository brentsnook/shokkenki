require_relative '../../spec_helper'
require 'shokkenki/consumer/request'

describe Shokkenki::Consumer::Request do

  subject do
    Shokkenki::Consumer::Request.new(
      :method => :get,
      :path => '/path'
    )
  end

  context 'when created' do


    it 'has the given method' do
      expect(subject.method_type).to eq(:get)
    end

    it 'has the given path' do
      expect(subject.path).to eq('/path')
    end

  end

  context 'as a hash' do

    it 'includes the method' do
      expect(subject.to_hash[:method]).to eq(:get)
    end

    it 'includes the path' do
      expect(subject.to_hash[:path]).to eq('/path')
    end

  end
end
