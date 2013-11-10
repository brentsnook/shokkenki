module Shokkenki
  module Provider
    module Model
      class RackHttpClient

        def initialize app

        end

        def response_for request
          {:status => 200, :body => 'why hello there'}
        end
      end
    end
  end
end