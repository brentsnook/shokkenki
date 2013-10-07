require_relative '../../spec_helper'
require 'shokkenki/consumer/response'

describe Shokkenki::Consumer::Response do

  context 'when created' do

    subject do
      Shokkenki::Consumer::Response.new(
        :body => /hello/
      )
    end

    it 'has the given body' do
      expect(subject.body).to eq(/hello/)
    end

  end
end
