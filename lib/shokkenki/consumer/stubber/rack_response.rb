module Shokkenki
  module Consumer
    module Stubber
      class RackResponse

        def self.from_interaction interaction
          [200, {}, ['hello kitty']]
        end

      end
    end
  end
end