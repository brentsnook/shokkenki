require 'json'
require 'shokkenki/consumer/stubber/request'

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
          interaction ? interaction.response.to_rack_response : no_interaction(request)
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