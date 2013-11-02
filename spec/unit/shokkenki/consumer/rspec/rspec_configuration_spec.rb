require_relative '../../../spec_helper'
require 'shokkenki/consumer/rspec/example_group_binding'
require 'shokkenki/consumer/rspec/hooks'

describe 'RSpec configuration' do

  let(:config) { double('RSpec configuration', :before => '', :after => '').as_null_object }
  let(:load_config) { load 'shokkenki/consumer/rspec/rspec_configuration.rb' }
  let(:session) { double('Shokkenki session').as_null_object }

  before do
    @filtered_to_consumer_examples = false
    allow(config).to receive(:include).with(Shokkenki::Consumer::RSpec::ExampleGroupBinding, anything) do |scope, filter|
      @filtered_to_consumer_examples = filter[:shokkenki_consumer].call ''
    end
  end

  let(:hooks) { Shokkenki::Consumer::RSpec::Hooks }

  before do
    allow(::RSpec).to receive(:configure).and_yield(config)
    allow(Shokkenki).to receive(:consumer).and_return session
    allow(hooks).to receive(:before_each)
    allow(hooks).to receive(:after_each)
    allow(hooks).to receive(:before_suite)
    allow(hooks).to receive(:after_suite)
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

    let(:consumer_metadata) { {:name => :consumername } }
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
    end

    before { load_config }

    it 'only runs the hook for shokkenki consumer examples' do
      expect(@filtered_to_consumer_examples).to be_true
    end

    it 'runs the before each hook with the metadata' do
      expect(hooks).to have_received(:before_each).with(consumer_metadata)
    end

  end

  context 'after each example runs' do

    let(:example_group) { double('example group', :example => example) }

    before do
      @filtered_to_consumer_examples = false
      allow(config).to receive(:after).with(:each, anything) do |scope, filter, &block|
        example_group.instance_eval &block
        @filtered_to_consumer_examples = filter[:shokkenki_consumer].call ''
      end
    end

    before { load_config }

    it 'only runs the hook for shokkenki consumer examples' do
      expect(@filtered_to_consumer_examples).to be_true
    end

    it 'runs the after each hook' do
      expect(hooks).to have_received(:after_each)
    end

  end

  context 'before the test suite begins' do
    before do
      allow(config).to receive(:before).with(:suite).and_yield
      load_config
    end

    it 'runs the before suite hook' do
      expect(hooks).to have_received(:before_suite)
    end

  end

  context 'after the test suite finishes' do

    before do
      allow(config).to receive(:after).with(:suite).and_yield
      load_config
    end

    it 'runs the after suite hook' do
      expect(hooks).to have_received(:after_suite)
    end
  end
end