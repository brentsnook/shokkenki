require_relative 'role'
require_relative '../stubber/http_stubber'

module Shokkenki
  module Consumer
    module Model
      class Provider < Role

        attr_reader :stubber

        def initialize attributes
          super attributes
          @stubber = attributes[:stubber] || Shokkenki::Consumer::Stubber::HttpStubber.new({})
        end

        def stub_interaction interaction
          @stubber.stub_interaction interaction
        end

        def clear_interaction_stubs
          @stubber.clear_interaction_stubs
        end

        def session_started
          @stubber.session_started
        end

        def session_closed
          @stubber.session_closed
        end
      end
    end
  end
end