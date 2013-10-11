require_relative '../../../spec_helper'
require 'shokkenki/consumer/rspec/example_group_binding'
require 'shokkenki/shokkenki'

describe 'RSpec configuration' do

  let(:config) { double('RSpec configuration').as_null_object }
  let(:load_config) { load 'shokkenki/consumer/rspec/rspec_configuration.rb' }
  let(:session) { double('Shokkenki session').as_null_object }

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
    expect(config).to have_received(:include).with(Shokkenki::Consumer::RSpec::ExampleGroupBinding)
  end

  context 'before each example runs' do

    let(:consumer_metadata) { double('metadata') }
    let(:metadata) { {:shokkenki_consumer => consumer_metadata} }
    let(:example) { double('example', :metadata => metadata)}
    let(:example_group) { double('example group', :example => example) }

    before do
      # simulating what happens with an example group
      # sucks, need a better way to test this
      @filter_result = false
      allow(config).to receive(:before).with(:each, anything) do |scope, filter, &block|
        example_group.instance_eval &block
        @filter_result = filter[:shokkenki_consumer].call ''
      end

      load_config
    end

    # this allows an implicit consumer to be referred to in the DSL
    it 'sets a new consumer using the shokkenki metadata' do
      expect(session).to have_received(:current_consumer=).with consumer_metadata
    end

    it 'sets a new consumer for any shokkenki consumer example' do
      expect(@filter_result).to be_true
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
  end
end