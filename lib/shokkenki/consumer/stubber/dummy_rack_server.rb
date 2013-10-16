# temporary rack server - just logs out requests

module Shokkenki
  module Consumer
    module Stubber
      class DummyRackServer
        def call env
          [200, {}, ['hello kitty']]
        end
      end
    end
  end
end