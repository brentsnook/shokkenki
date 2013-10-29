module Shokkenki
  module Consumer
    module Model
      class Fixture

        attr_reader :name, :arguments

        def initialize attributes
          @name = attributes[:name]
          @arguments = attributes[:arguments]
        end

        def to_hash
          hash = {:name => @name}
          hash.merge!(:arguments => @arguments) if @arguments
          hash
        end
      end
    end
  end
end