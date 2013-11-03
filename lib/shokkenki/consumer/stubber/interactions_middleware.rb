require_relative 'interaction'
require_relative 'restful_middleware'
require 'json'

module Shokkenki
  module Consumer
    module Stubber
      class InteractionsMiddleware < RestfulMiddleware

        def initialize interactions
          @interactions = interactions
        end

        get { |env| [200, {}, ["[]"]] }

        post do |env|
          @interactions.add Interaction.from_json(body_json(env['rack.input']))
          [204, {}, []]
        end

        delete do |env|
          @interactions.delete_all
          [204, {}, []]
        end

        private

        def body_json body_io
          JSON.parse body_io.read
        end
      end
    end
  end
end