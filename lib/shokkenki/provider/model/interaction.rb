require 'shokkenki/term/and_expression_term'
require 'shokkenki/term/number_term'
require 'shokkenki/term/regexp_term'

module Shokkenki
  module Provider
    module Model
      class Interaction
        attr_reader :label, :response
        def initialize
          @label = 'greeting'
          @response = Shokkenki::Term::AndExpressionTerm.new(
            :status => Shokkenki::Term::NumberTerm.new(200),
            :body => Shokkenki::Term::RegexpTerm.new(/hello there/)
          )
        end
      end
    end
  end
end