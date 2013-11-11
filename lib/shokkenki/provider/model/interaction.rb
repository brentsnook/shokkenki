require 'shokkenki/term/and_expression_term'
require 'shokkenki/term/number_term'
require 'shokkenki/term/regexp_term'

module Shokkenki
  module Provider
    module Model
      class Interaction
        attr_reader :label, :response, :request
        def initialize
          @label = 'greeting'
          @request = Shokkenki::Term::AndExpressionTerm.new(
            :method => Shokkenki::Term::StringTerm.new(:get),
            :path => Shokkenki::Term::StringTerm.new('/greeting')
          )
          @response = Shokkenki::Term::AndExpressionTerm.new(
            :status => Shokkenki::Term::NumberTerm.new(200),
            :body => Shokkenki::Term::RegexpTerm.new(/hello there/)
          )
        end
      end
    end
  end
end