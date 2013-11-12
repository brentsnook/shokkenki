require 'active_support/core_ext/hash/keys'
require_relative 'role'
require_relative 'interaction'

module Shokkenki
  module Provider
    module Model
      class Ticket

        attr_reader :provider, :interactions, :consumer

        def initialize provider, consumer, interactions
          @provider = provider
          @consumer = consumer
          @interactions = interactions
        end

        def self.from_json json
          from_hash(JSON.parse(json).symbolize_keys)
        end

        def self.from_hash hash
          new(
            Role.from_hash(hash[:provider].symbolize_keys),
            Role.from_hash(hash[:consumer].symbolize_keys),
            hash[:interactions].map{ |h| Interaction.from_hash h.symbolize_keys }
          )
        end
      end
    end
  end
end