require_relative '../../../spec_helper'
require 'shokkenki/consumer/configuration/session'

describe Shokkenki::Consumer::Configuration::Session do

  class StubSession
    include Shokkenki::Consumer::Configuration::Session
    attr_accessor :property
  end

  subject { StubSession.new }

  context 'being configured' do

    context 'with directives' do
      before do
        subject.configure do |config|
          config.property = 'some value'
        end
      end

      it 'applies those to the configuration' do
        expect(subject.property).to eq('some value')
      end
    end

    context 'with no directives' do
      it 'does nothing' do
        expect{ subject.configure }.to_not raise_error
      end
    end
  end
end