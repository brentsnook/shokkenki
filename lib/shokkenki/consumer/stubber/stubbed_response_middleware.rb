module Shokkenki
  module Consumer
    module Stubber
      class StubbedResponseMiddleware

        def call env
          [200, {}, ['hello kitty']]
        end
      end
    end
  end
end