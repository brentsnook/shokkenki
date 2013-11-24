require 'shokkenki/term/string_term'
require_relative 'hash_term'
require_relative 'regexp_term'
require_relative 'number_term'
require_relative 'json_paths_term'

module Shokkenki
  module Term
    class TermFactory

      def self.factories
        @factories ||= {
          :string => StringTerm,
          :hash => HashTerm,
          :regexp => RegexpTerm,
          :number => NumberTerm,
          :json_paths => JsonPathsTerm
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