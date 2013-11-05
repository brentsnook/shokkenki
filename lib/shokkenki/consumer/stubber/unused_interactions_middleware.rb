require_relative 'restful_middleware'
require 'json'

module Shokkenki
  module Consumer
    module Stubber
      class UnusedInteractionsMiddleware < RestfulMiddleware

        def initialize interactions
          @interactions = interactions
        end

        get do |env|
          interactions = @interactions.unused_interactions
          json = JSON.pretty_generate(interactions.collect{|r| r.to_hash})
          [200, {'Content-Type' => 'application/json'}, [json]]
        end
      end
    end
  end
end