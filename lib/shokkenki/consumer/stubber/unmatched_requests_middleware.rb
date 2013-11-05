require_relative 'interaction'
require_relative 'restful_middleware'
require 'json'

module Shokkenki
  module Consumer
    module Stubber
      class UnmatchedRequestsMiddleware < RestfulMiddleware

        def initialize interactions
          @interactions = interactions
        end

        get do |env|
          requests = @interactions.unmatched_requests
          json = JSON.pretty_generate(requests.collect{|r| r.to_hash})
          [200, {'Content-Type' => 'application/json'}, [json]]
        end
      end
    end
  end
end