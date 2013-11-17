require 'shokkenki/term/term_factory'
require_relative 'fixture_requirement'

module Shokkenki
  module Provider
    module Model
      class Interaction
        attr_reader :label, :response, :request, :required_fixtures

        def initialize label, request, response, required_fixtures
          @label = label
          @request = request
          @response = response
          @required_fixtures = required_fixtures
        end

        def self.from_hash hash
          new(
            hash[:label],
            Shokkenki::Term::TermFactory.from_json(hash[:request]),
            Shokkenki::Term::TermFactory.from_json(hash[:response]),
            hash[:fixtures].map {|f| FixtureRequirement.from_hash f }
          )
        end
      end
    end
  end
end