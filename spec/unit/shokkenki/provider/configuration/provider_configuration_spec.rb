require_relative '../../../spec_helper'
require 'shokkenki/provider/configuration/provider_configuration'

describe Shokkenki::Provider::Configuration::ProviderConfiguration do

  subject { Shokkenki::Provider::Configuration::ProviderConfiguration.new :name }

  context 'when created' do
    it 'has the given name' do
      expect(subject.name).to eq(:name)
    end
  end

  context 'run' do
    let(:rack_app) { double 'rack app' }
    before { subject.run rack_app }
    it 'allows the Rack application for the provider to be set' do
      expect(subject.app).to be(rack_app)
    end
  end
end