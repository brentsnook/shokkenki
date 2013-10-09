require_relative '../../../spec_helper'
require 'shokkenki/consumer/model/role'

describe Shokkenki::Consumer::Model::Role do
  context 'when created' do

    subject { Shokkenki::Consumer::Model::Role.new :name => :ROLenaMe}

    it 'simplifies the name it is given' do
      expect(subject.name).to eq(:rolename)
    end

    context 'when a label is supplied' do

      subject { Shokkenki::Consumer::Model::Role.new :name => :name, :label => 'Pretty Name' }

      it 'uses the label it is given' do
        expect(subject.label).to eq('Pretty Name')
      end

    end

    context 'when no label is supplied' do

      subject { Shokkenki::Consumer::Model::Role.new :name => :some_name }

      it 'prettifies the name and uses that as the label' do
        expect(subject.label).to eq('Some Name')
      end

    end

  end

  context 'as a hash' do

    subject { Shokkenki::Consumer::Model::Role.new :name => :rolename, :label => 'label' }

    it 'includes the name' do
      expect(subject.to_hash[:name]).to eq(:rolename)
    end

    it 'includes the label' do
      expect(subject.to_hash[:label]).to eq('label')
    end
  end
end
