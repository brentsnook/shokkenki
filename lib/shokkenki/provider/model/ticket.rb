require 'ostruct'
require 'active_support/core_ext/hash/keys'

module Shokkenki
  module Provider
    module Model

      # At the moment this class is FITYMI
      class Ticket

        attr_reader :provider, :interactions, :consumer

        def initialize provider, consumer, interactions
          @provider = provider
          @consumer = consumer
          @interactions = interactions
        end

        def self.from_json json
          from_hash(JSON.parse(json))
        end

        def self.from_hash hash
          new(
            OpenStruct.new(hash['provider'].symbolize_keys),
            OpenStruct.new(hash['consumer'].symbolize_keys),
            [ Interaction.new ]
          )
        end
      end
    end
  end
end