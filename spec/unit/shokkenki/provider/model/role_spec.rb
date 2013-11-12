require_relative '../../../spec_helper'
require 'shokkenki/provider/model/role'

describe Shokkenki::Provider::Model::Role do
  context 'created from a hash' do

    let(:role) do
      Shokkenki::Provider::Model::Role.from_hash(
        :name => 'name',
        :label => 'label'
      )
    end

    it 'has a name' do
      expect(role.name).to eq('name')
    end

    it 'has a label' do
      expect(role.label).to eq('label')
    end

  end
end