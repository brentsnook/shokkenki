require_relative 'term'
require_relative 'core_ext'

module Shokkenki
  module Term
    class AndExpressionTerm < Term

      attr_reader :type, :values

      def self.from_json json
        values = json['values'].inject({}) do |hash, kv|
          key, value = *kv
          hash[key.to_sym] = TermFactory.from_json(value)
          hash
        end

        new values
      end

      def initialize values
        @values = values.inject({}) do |mapped, kv|
          k,v = *kv
          mapped[k] = v.to_shokkenki_term
          mapped
        end

        @type = :and_expression
      end

      def to_hash
        mapped_values = @values.inject({}) do |mapped, keyvalue|
          key, value = *keyvalue
          mapped[key] = value.respond_to?(:to_hash) ? value.to_hash : value
          mapped
        end

        {
          :type => @type,
          :values => mapped_values
        }
      end

      def example
        @values.inject({}) do |hash, kv|
          key, value = *kv
          hash[key] = value.example
          hash
        end
      end

      def match? compare
        compare && @values.all? do |key, value|
          value.match? compare.to_hash[key]
        end
      end
    end
  end
end