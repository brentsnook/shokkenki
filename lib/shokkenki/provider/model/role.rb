module Shokkenki
  module Provider
    module Model
      class Role

        attr_reader :name, :label

        def self.from_hash hash
          new(hash[:name], hash[:label])
        end

        def initialize name, label
          @name = name
          @label = label
        end
      end
    end
  end
end