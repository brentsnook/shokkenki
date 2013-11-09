require 'shokkenki/term/and_expression_term'

module Shokkenki
  module Provider
    module Model
      class Interaction
        attr_reader :label, :response
        def initialize
          @label = 'greeting'
          @response = Shokkenki::Term::AndExpressionTerm.new []
        end
      end
    end
  end
end