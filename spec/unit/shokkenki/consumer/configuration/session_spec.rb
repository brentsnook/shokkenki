require_relative '../../../spec_helper'
require 'shokkenki/consumer/configuration/session'
require 'shokkenki/consumer/stubber/http_stubber'

describe Shokkenki::Consumer::Configuration::Session do

  class StubSession
    include Shokkenki::Consumer::Configuration::Session
    attr_accessor :property
  end

  subject { StubSession.new }

  describe 'stubber classes' do
    context 'by default' do
      it 'stubs :local_server with the HTTP stubber' do
        expect(subject.stubber_classes).to include({ :local_server => Shokkenki::Consumer::Stubber::HttpStubber })
      end
    end
  end

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

  context 'registering a stubber' do
    let(:stubber_class) { double('stubber class') }

    before do
      subject.register_stubber :stubber_name, stubber_class
    end

    it 'sets the class to be used when creating a named stubber' do
      expect(subject.stubber_classes).to include({ :stubber_name => stubber_class })
    end
  end

  context 'defining a provider' do

    let(:configuration) { double('provider configuration', :to_provider => provider).as_null_object }
    let(:provider) { double 'provider' }

    before do
      allow(Shokkenki::Consumer::Configuration::ProviderConfiguration).to receive(:new).and_return configuration
      allow(subject).to receive(:add_provider)
      define_provider
    end

    let(:define_provider) do
      subject.define_provider :provider_name
    end

    it 'sets the name of the provider' do
      expect(Shokkenki::Consumer::Configuration::ProviderConfiguration).to have_received(:new).with(:provider_name, anything)
    end

    it 'sets the stubber classes' do
      expect(Shokkenki::Consumer::Configuration::ProviderConfiguration).to have_received(:new).with(anything, subject.stubber_classes)
    end

    context 'with directives' do

      let(:define_provider) do
        subject.define_provider(:provider_name) do |p|
          p.set_some_details
        end
      end

      it 'configures the provider' do
        expect(configuration).to have_received(:set_some_details)
      end
    end

    it 'adds a new provider using the details' do
      expect(subject).to have_received(:add_provider).with provider
    end
  end
end