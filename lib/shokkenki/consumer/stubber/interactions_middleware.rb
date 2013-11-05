require_relative 'interaction'
require 'json'

module Shokkenki
  module Consumer
    module Stubber
      class InteractionsMiddleware

        def initialize interactions
          @interactions = interactions
        end

        def call env
          case env['REQUEST_METHOD'].upcase
          when 'POST'
            @interactions.add Interaction.from_json(body_json(env['rack.input']))
            [204, {}, []]
          when 'DELETE'
            @interactions.delete_all
            [204, {}, []]
          else
            [405, {'Allow' => 'POST, DELETE'}, []]
          end
        end

        private

        def body_json body_io
          JSON.parse body_io.read
        end
      end
    end
  end
end