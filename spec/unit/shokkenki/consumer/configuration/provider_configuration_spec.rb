require_relative '../../../spec_helper'
require 'shokkenki/consumer/configuration/provider_configuration'

describe Shokkenki::Consumer::Configuration::ProviderConfiguration do

  context 'stub with' do
    let(:attributes) { { :attribute => '' } }
    let(:provider_attributes) { subject.as_attributes }
    let(:stubber) { double('stubber') }
    let(:stubber_classes) { { :stubby => double('stubber class', :new => stubber) } }

    subject do
      Shokkenki::Consumer::Configuration::ProviderConfiguration.new(
        :provider_name,
        stubber_classes
      )
    end

    context 'when the stubber is recognised' do

      before do
        subject.stub_with(:stubby, attributes)
      end

      it 'stores a newly created stubber' do
        expect(subject.to_attributes[:stubber]).to be(stubber)
      end

      it 'creates the stubber with the given attributes' do
        expect(stubber_classes[:stubby]).to have_received(:new).with attributes
      end
    end

    context 'when the stubber is not recognised' do

      it 'fails' do
        expect { subject.stub_with(:nonexistent, attributes) }.to raise_error("No stubber found named 'nonexistent'.")
      end
    end
  end

  context 'validation' do

    subject do
      Shokkenki::Consumer::Configuration::ProviderConfiguration.new(
        :provider_name,
        {}
      )
    end

    context 'with no stubber' do

      it 'fails' do
        expect { subject.validate! }.to raise_error("No 'stub_with' has been specified.")
      end
    end
  end

  context 'as attributes' do

    subject do
      Shokkenki::Consumer::Configuration::ProviderConfiguration.new(
        :provider_name,
        {}
      )
    end

    it 'includes name' do
      expect(subject.to_attributes[:name]).to eq(:provider_name)
    end

    it 'includes label' do
      subject.label = 'provider label'
      expect(subject.to_attributes[:label]).to eq('provider label')
    end
  end
end