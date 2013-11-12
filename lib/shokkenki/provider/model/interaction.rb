require 'shokkenki/term/term_factory'

module Shokkenki
  module Provider
    module Model
      class Interaction
        attr_reader :label, :response, :request

        def initialize label, request, response
          @label = label
          @request = request
          @response = response
        end

        def self.from_hash hash
          new(
            hash[:label],
            Shokkenki::Term::TermFactory.from_json(hash[:request]),
            Shokkenki::Term::TermFactory.from_json(hash[:response])
          )
        end
      end
    end
  end
end