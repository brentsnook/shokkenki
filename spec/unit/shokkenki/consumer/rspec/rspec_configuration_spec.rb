require_relative '../../../spec_helper'
require 'shokkenki/consumer/rspec/example_group_binding'
require 'shokkenki/shokkenki'

describe 'RSpec configuration' do

  let(:config) { double('RSpec configuration', :before => '').as_null_object }
  let(:load_config) { load 'shokkenki/consumer/rspec/rspec_configuration.rb' }
  let(:session) { double('Shokkenki session').as_null_object }

  before do
    @filtered_to_consumer_examples = false
    allow(config).to receive(:include).with(Shokkenki::Consumer::RSpec::ExampleGroupBinding, anything) do |scope, filter|
      @filtered_to_consumer_examples = filter[:shokkenki_consumer].call ''
    end
  end

  before do
    allow(::RSpec).to receive(:configure).and_yield(config)
    allow(Shokkenki).to receive(:consumer).and_return session
  end

  it 'treats symbols as keys to prepare for RSpec 3' do
    load_config
    expect(config).to have_received(:treat_symbols_as_metadata_keys_with_true_values=).with(true)
  end

  it 'includes the example group binding to make the DSL available' do
    load_config
    expect(config).to have_received(:include).with(Shokkenki::Consumer::RSpec::ExampleGroupBinding, anything)
  end

  # we want to avoid defining methods on the example group unless we have to.
  # this lessens the chance of a collision with something else
  it 'only makes the DSL available to shokkenki consumer examples' do
    load_config
    expect(@filtered_to_consumer_examples).to be_true
  end

  context 'before each example runs' do

    let(:consumer_metadata) { double('metadata') }
    let(:metadata) { {:shokkenki_consumer => consumer_metadata} }
    let(:example) { double('example', :metadata => metadata)}
    let(:example_group) { double('example group', :example => example) }

    before do
      # simulating what happens with an example group
      # sucks, need a better way to test this
      @filtered_to_consumer_examples = false
      allow(config).to receive(:before).with(:each, anything) do |scope, filter, &block|
        example_group.instance_eval &block
        @filtered_to_consumer_examples = filter[:shokkenki_consumer].call ''
      end

      load_config
    end

    # this allows an implicit consumer to be referred to in the DSL
    it 'sets a new consumer using the shokkenki metadata' do
      expect(session).to have_received(:current_consumer=).with consumer_metadata
    end

    it 'sets a new consumer for any shokkenki consumer example' do
      expect(@filtered_to_consumer_examples).to be_true
    end

    it 'clears interaction stubs in the session' do
      expect(session).to have_received(:clear_interaction_stubs)
    end

  end

  context 'before the test suite begins' do
    before do
      allow(config).to receive(:before).with(:suite).and_yield
      load_config
    end

    it 'starts the session' do
      expect(session).to have_received(:start)
    end

  end

  context 'after the test suite finishes' do

    before do
      allow(config).to receive(:after).with(:suite).and_yield
      load_config
    end

    it 'prints out all tickets' do
      expect(session).to have_received(:print_tickets)
    end

    it 'closes the session' do
      expect(session).to have_received(:close)
    end
  end
end