require_relative '../../../spec_helper'
require 'shokkenki/provider/model/fixture_requirement'

describe Shokkenki::Provider::Model::FixtureRequirement do
  context 'created from a hash' do
    let(:requirement) do
      Shokkenki::Provider::Model::FixtureRequirement.from_hash(
        'name' => 'stuff exists',
        'arguments' => {
          'stuff1' => 'stuff1 value'
        }
      )
    end

    it 'has a name' do
      expect(requirement.name).to eq('stuff exists')
    end

    it 'has arguments that use symbolic keys' do
      expect(requirement.arguments[:stuff1]).to eq('stuff1 value')
    end
  end
end