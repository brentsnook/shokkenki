require_relative '../../shokkenki'

module Shokkenki
  module Consumer
    module RSpec
      module ExampleGroupBinding
        def shokkenki
          Shokkenki.consumer
        end
      end
    end
  end
end