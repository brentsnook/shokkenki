require_relative 'interaction'
require_relative 'restful_middleware'
require 'json'

module Shokkenki
  module Consumer
    module Stubber
      class RequestsMiddleware < RestfulMiddleware

        def initialize interactions
          @interactions = interactions
        end

        get do |env|
          env['PATH_INFO'].end_with?('unmatched') ? find_unmatched(env) : not_found
        end

        private

        def find_unmatched env
          requests = @interactions.unmatched_requests
          json = JSON.pretty_generate(requests.collect{|r| r.to_hash})
          [200, {'Content-Type' => 'application/json'}, [json]]
        end

        def not_found
          [404, {}, []]
        end
      end
    end
  end
end