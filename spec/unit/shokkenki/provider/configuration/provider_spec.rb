require_relative '../../../spec_helper'
require 'shokkenki/provider/configuration/provider'

describe Shokkenki::Provider::Configuration::Provider do

  class StubProvider
    include Shokkenki::Provider::Configuration::Provider

    attr_reader :app
  end

  subject { StubProvider.new }

  context 'run' do
    let(:rack_app) { double 'rack app' }
    before { subject.run rack_app }
    it 'allows the Rack application for the provider to be set' do
      expect(subject.app).to be(rack_app)
    end
  end
end