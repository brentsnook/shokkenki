require 'json'
require_relative 'request'
require_relative 'rack_response'

module Shokkenki
  module Consumer
    module Stubber
      class StubbedResponseMiddleware

        def initialize interactions
          @interactions = interactions
        end

        def call env
          request = Request.from_rack env
          interaction = @interactions.find request
          interaction ? RackResponse.from_interaction(interaction) : no_interaction(request)
        end

        private

        def no_interaction request
          body = {
            :shokkenki => {
              :message => 'No matching responses were found for the request.',
              :request => request.to_hash
            }
          }
          [404, {'Content-Type' => 'application/json'}, [body.to_json]]
        end
      end
    end
  end
end