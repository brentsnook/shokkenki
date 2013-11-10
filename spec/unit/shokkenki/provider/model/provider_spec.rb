require_relative '../../../spec_helper'
require 'shokkenki/provider/model/provider'

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
end