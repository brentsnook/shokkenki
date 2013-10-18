require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/interaction'

describe Shokkenki::Consumer::Stubber::Interaction do
  context 'created from a rack env' do
    it 'creates terms for request'
  end

  context 'matching a request' do
    it 'matches using the request term'
  end

  it 'somehow allows new terms to be registered'
  it 'fails when term is not recognised'
end