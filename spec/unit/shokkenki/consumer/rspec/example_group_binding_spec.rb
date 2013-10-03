require_relative '../../../spec_helper'
require 'shokkenki/consumer/session'
require 'shokkenki/consumer/rspec/example_group_binding'

describe Shokkenki::Consumer::RSpec::ExampleGroupBinding do

  class BoundExampleGroup
    include Shokkenki::Consumer::RSpec::ExampleGroupBinding
  end

  let(:bound_example_group) do
    BoundExampleGroup.new
  end

  # this is the entry point for the DSL
  it "makes the session available as 'shokkenki'" do
    expect(bound_example_group.shokkenki).to be(Shokkenki::Consumer::Session.singleton)
  end
end
