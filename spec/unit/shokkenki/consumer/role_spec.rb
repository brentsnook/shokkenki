require_relative '../../spec_helper'
require 'shokkenki/consumer/role'

describe Shokkenki::Consumer::Role do
  context 'when created' do

    subject { Shokkenki::Consumer::Role.new :name => :ROLenaMe}

    it 'simplifies the name it is given' do
      expect(subject.name).to eq(:rolename)
    end

  end

  context 'as a hash' do

    subject { Shokkenki::Consumer::Role.new :name => :rolename}

    it 'includes the name' do
      expect(subject.to_hash[:name]).to eq(:rolename)
    end
  end
end
