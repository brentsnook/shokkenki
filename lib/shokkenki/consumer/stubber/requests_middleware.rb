require_relative 'interaction'
require 'json'

module Shokkenki
  module Consumer
    module Stubber
      class RequestsMiddleware

        def initialize interactions
          @interactions = interactions
        end

        def call env
          env['PATH_INFO'].end_with?('unmatched') ? find_unmatched(env) : not_found
        end

        private

        def find_unmatched env
          case env['REQUEST_METHOD'].upcase
          when 'GET'
            requests = @interactions.unmatched_requests
            json = JSON.pretty_generate(requests.collect{|r| r.to_hash})
            [200, {'Content-Type' => 'application/json'}, [json]]
          else
            [405, {'Allow' => 'GET'}, []]
          end
        end

        def not_found
          [404, {}, []]
        end
      end
    end
  end
end