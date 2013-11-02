require_relative 'role'
require_relative '../stubber/http_stubber'

module Shokkenki
  module Consumer
    module Model
      class Provider < Role
        extend Forwardable
        def_delegators :@stubber, :stub_interaction, :clear_interaction_stubs,
          :session_started, :session_closed

        attr_reader :stubber

        def initialize attributes
          super attributes
          @stubber = attributes[:stubber] || Shokkenki::Consumer::Stubber::HttpStubber.new({})
        end

        def assert_all_requests_matched!
          unmatched_requests = @stubber.unmatched_requests
          message = "In provider '#{@name}' the following requests were not matched: #{JSON.pretty_generate(unmatched_requests)}"
          raise message unless unmatched_requests.empty?
        end
      end
    end
  end
end