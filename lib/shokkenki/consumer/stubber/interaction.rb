require 'active_support/core_ext/hash/indifferent_access'
require_relative '../../term/term_factory'

module Shokkenki
  module Consumer
    module Stubber
      class Interaction

        attr_reader :label, :request, :response, :time, :matched_requests

        def self.from_json json
          attributes = json.with_indifferent_access

          new(
            :label => attributes[:label],
            :request => Shokkenki::Term::TermFactory.from_json(attributes[:request]),
            :response => Shokkenki::Term::TermFactory.from_json(attributes[:response]),
            :time => attributes[:time]
          )
        end

        def initialize attributes
          @label = attributes[:label]
          @request = attributes[:request]
          @response = attributes[:response]
          @time = attributes[:time]
          @matched_requests = []
        end

        def to_hash
          {
            :label => @label
          }
        end

        def generate_response
          @response.example
        end

        def match_request? request
          @request.match? request
        end

        def add_match request
          @matched_requests << request
          request.interaction = self
        end
      end
    end
  end
end