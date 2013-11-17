require_relative '../../../spec_helper'
require 'shokkenki/provider/model/provider'
require 'shokkenki/provider/model/fixture'

describe Shokkenki::Provider::Model::Provider do

  subject { Shokkenki::Provider::Model::Provider.new :name }

  context 'when created' do
    it 'has the given name' do
      expect(subject.name).to eq(:name)
    end
  end

  it 'is configurable' do
    expect(subject).to respond_to(:run)
  end

  context 'adding a fixture' do
    let(:block) { lambda {} }
    let(:fixture) { double 'fixture' }

    before do
      allow(Shokkenki::Provider::Model::Fixture).to(
        receive(:new).with(/pattern/, block).and_return fixture
      )
      subject.add_fixture /pattern/, block
    end

    it 'adds a fixture that will run for a matching name pattern' do
      expect(subject.fixtures).to eq([fixture])
    end
  end

  context 'establishing fixtures' do

    let(:first_fixture) { double(:first_fixture).as_null_object }

    let(:second_fixture) { double(:second_fixture).as_null_object }
    let(:required_fixture) { double(:required_fixture) }

    before do
      subject.fixtures << first_fixture
      subject.fixtures << second_fixture
      subject.establish [required_fixture]
    end

    it 'establishes each fixture' do
      expect(first_fixture).to have_received(:establish).with(required_fixture)
      expect(first_fixture).to have_received(:establish).with(required_fixture)
    end
  end
end