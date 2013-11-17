require 'active_support/core_ext/hash/keys'

module Shokkenki
  module Provider
    module Model
      class FixtureRequirement

        attr_reader :name, :arguments

        def initialize name, arguments
          @name = name
          @arguments = arguments
        end

        def self.from_hash hash
          symbolized_hash = hash.deep_symbolize_keys
          new symbolized_hash[:name], symbolized_hash[:arguments]
        end
      end
    end
  end
end
