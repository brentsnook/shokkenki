module Shokkenki
  module Consumer
    module Stubber
      class Interaction

        def self.from_rack env
          new
        end

        def response
          Response.new
        end

        def match_request? request
          true
        end
      end
    end
  end
end