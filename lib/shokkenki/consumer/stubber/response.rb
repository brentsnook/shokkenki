module Shokkenki
  module Consumer
    module Stubber
      class Response

        def to_rack_response
          [200, {}, ['hello kitty']]
        end

      end
    end
  end
end