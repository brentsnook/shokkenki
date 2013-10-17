module Shokkenki
  module Consumer
    module Stubber
      class InteractionsMiddleware

        def initialize interactions

        end

        def call env
          [200, {}, ['fake admin stuff']]
        end
      end
    end
  end
end