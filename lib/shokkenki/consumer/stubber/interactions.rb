require 'shokkenki/consumer/stubber/response'

module Shokkenki
  module Consumer
    module Stubber
      class Interactions

        def find request
          Shokkenki::Consumer::Stubber::Response.new
        end

      end
    end
  end
end