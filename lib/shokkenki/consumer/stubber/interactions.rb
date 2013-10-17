require 'shokkenki/consumer/stubber/response'

module Shokkenki
  module Consumer
    module Stubber
      class Interactions

        def find request
          Response.new
        end

        def delete_all

        end

        def add interaction

        end
      end
    end
  end
end