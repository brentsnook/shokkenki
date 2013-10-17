require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/interactions_middleware'

describe Shokkenki::Consumer::Stubber::InteractionsMiddleware do
  context 'when the request is to create a new interaction' do
    it 'creates the new interaction'
  end

  context 'when the request is to delete all interactions' do
    it 'deletes all interactions'
  end
end