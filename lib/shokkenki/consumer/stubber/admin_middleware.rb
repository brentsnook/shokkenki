module Shokkenki
  module Consumer
    module Stubber
      class AdminMiddleware
        def call env
          [200, {}, ['fake admin stuff']]
        end
      end
    end
  end
end