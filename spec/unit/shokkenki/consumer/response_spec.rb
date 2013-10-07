require_relative '../../spec_helper'
require 'shokkenki/consumer/response'

describe Shokkenki::Consumer::Response do

  subject do
    Shokkenki::Consumer::Response.new(
      :body => /hello/
    )
  end

  context 'when created' do

    it 'has the given body' do
      expect(subject.body).to eq(/hello/)
    end

  end

  context 'as a hash' do
    it 'includes the body' do
      expect(subject.to_hash[:body]).to eq(/hello/)
    end
  end
end
