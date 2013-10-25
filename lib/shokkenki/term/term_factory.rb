require 'shokkenki/term/string_term'
require 'shokkenki/term/and_expression_term'
require 'shokkenki/term/regexp_term'
require 'shokkenki/term/number_term'

module Shokkenki
  module Term
    class TermFactory

      def self.factories
        @factories ||= {
          :string => StringTerm,
          :and_expression => AndExpressionTerm,
          :regexp => RegexpTerm,
          :number => NumberTerm
        }
      end

      def self.factory_for type
        raise 'There is no term type' unless type
        factories[type.to_s.downcase.to_sym] || raise("Term of type '#{type}' is not recognised. Have you registered a factory for it?")
      end

      def self.register type, factory
        factories[type.to_s.downcase.to_sym] = factory
      end

      def self.from_json json
        factory_for(json['type']).from_json json
      end
    end
  end
end