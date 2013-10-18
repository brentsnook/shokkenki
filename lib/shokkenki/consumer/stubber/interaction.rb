module Shokkenki
  module Consumer
    module Stubber
      class Interaction

        def self.from_rack env
          new
        end

        def generate_response
          {
            :status => 200,
            :headers => {},
            :body => 'hello kitty'
          }
        end

        def match_request? request
          true
        end
      end
    end
  end
end