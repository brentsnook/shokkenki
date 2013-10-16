module Shokkenki
  module Consumer
    module Stubber
      class Request

        def self.from_rack env
          new
        end

        def to_hash
          {

          }
        end
      end
    end
  end
end