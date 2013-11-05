require_relative '../../spec_helper'
require 'shokkenki/consumer/consumer'

describe Shokkenki do

  # testing frameworks like RSpec require a singleton to maintain state
  # between hooks
  it 'has a singleton consumer session to maintain state' do
    expect(Shokkenki.consumer).to_not be_nil
  end

end