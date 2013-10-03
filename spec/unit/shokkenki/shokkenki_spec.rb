require_relative '../spec_helper'
require 'shokkenki/shokkenki'

describe Shokkenki do

  # testing frameworks like RSpec require a singleton to maintain state
  # between hooks
  it 'has a singleton configuration to maintain state' do
    expect(Shokkenki.configuration).to_not be_nil
  end

  context 'being configured' do

    let(:configuration) { double('configuration').as_null_object }

    before do
      allow(Shokkenki).to receive(:configuration).and_return configuration
    end

    context 'with directives' do
      before do
        Shokkenki.configure do |config|
          config.some_directive 'some value'
        end
      end

      it 'applies those to the configuration' do
        expect(configuration).to have_received(:some_directive).with('some value')
      end
    end

    context 'with no directives' do
      before { Shokkenki.configure }

      it 'applies nothing' do
        expect(configuration).to_not have_received(anything)
      end
    end
  end
end