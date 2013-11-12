require_relative '../../../spec_helper'
require 'shokkenki/provider/model/ticket'
require 'shokkenki/provider/model/role'
require 'shokkenki/provider/model/interaction'

describe Shokkenki::Provider::Model::Ticket do

  let(:interaction_hash) { { :label => 'interaction' } }
  let(:consumer_hash) { { :label => 'consumer' } }
  let(:provider_hash) { { :label => 'provider' } }

  let(:interaction) { double 'interaction' }
  let(:consumer) { double 'consumer' }
  let(:provider) { double 'provider' }

  let(:ticket_hash) do
    {
      :provider => provider_hash,
      :consumer => consumer_hash,
      :interactions => [interaction_hash]
    }
  end

  before do
    allow(Shokkenki::Provider::Model::Role).to(
      receive(:from_hash).with(provider_hash).and_return provider
    )
    allow(Shokkenki::Provider::Model::Role).to(
      receive(:from_hash).with(consumer_hash).and_return consumer
    )
    allow(Shokkenki::Provider::Model::Interaction).to(
      receive(:from_hash).with(interaction_hash).and_return interaction
    )
  end

  context 'created from a hash' do

    let(:ticket) { Shokkenki::Provider::Model::Ticket.from_hash(ticket_hash)}

    it 'creates provider from a hash' do
      expect(ticket.provider).to eq(provider)
    end

    it 'creates consumer from a hash' do
      expect(ticket.consumer).to eq(consumer)
    end

    it 'creates each interaction from a hash' do
      expect(ticket.interactions).to eq([interaction])
    end
  end

  context 'created from JSON' do

    let(:ticket) { Shokkenki::Provider::Model::Ticket.from_json(ticket_hash.to_json) }

    it 'creates provider from a hash' do
      expect(ticket.provider).to eq(provider)
    end

    it 'creates consumer from a hash' do
      expect(ticket.consumer).to eq(consumer)
    end

    it 'creates each interaction from a hash' do
      expect(ticket.interactions).to eq([interaction])
    end
  end
end