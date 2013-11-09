module Shokkenki
  module Provider
    module Model
      class Interaction
        attr_reader :label
        def initialize
          @label = 'greeting'
        end
      end
    end
  end
end