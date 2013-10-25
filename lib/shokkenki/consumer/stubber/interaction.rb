require 'active_support/core_ext/hash/indifferent_access'
require 'shokkenki/term/term_factory'

module Shokkenki
  module Consumer
    module Stubber
      class Interaction

        attr_reader :label, :request, :response, :time

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
        end

        def generate_response
          @response.example
        end

        def match_request? request
          @request.match? request
        end
      end
    end
  end
end