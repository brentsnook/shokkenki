require_relative '../../spec_helper'
require 'shokkenki/provider/provider'

describe Shokkenki do

  # testing frameworks like RSpec require a singleton to maintain state
  # between hooks
  it 'has a singleton provider session to maintain state' do
    expect(Shokkenki.provider).to_not be_nil
  end

end