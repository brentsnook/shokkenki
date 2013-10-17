require 'shokkenki/consumer/stubber/interaction'

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
            @interactions.add Interaction.from_rack(env)
            [204, {}, []]
          when 'DELETE'
            @interactions.delete_all
            [204, {}, []]
          else
            [405, {'Allow' => ['POST', 'DELETE']}, []]
          end
        end
      end
    end
  end
end