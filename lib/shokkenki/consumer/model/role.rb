require_relative 'simplification'
require 'active_support/core_ext/string/inflections'

module Shokkenki
  module Consumer
    module Model
      class Role
        include Simplification

        attr_reader :name, :label

        def initialize arguments
          @name = simplify(arguments[:name])
          @label = arguments[:label] || @name.to_s.titleize
        end

        def to_hash
          {
            :name => @name,
            :label => @label
          }
        end

      end
    end
  end
end