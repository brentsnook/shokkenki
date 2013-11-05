require_relative '../consumer'

module Shokkenki
  module Consumer
    module RSpec
      module ExampleGroupBinding
        def shokkenki
          Shokkenki.consumer
        end

        def order provider
          shokkenki.order provider
        end
      end
    end
  end
end