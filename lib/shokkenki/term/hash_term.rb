require_relative 'term'
require_relative 'core_ext'

module Shokkenki
  module Term
    class HashTerm < Term

      attr_reader :type, :value

      def self.from_json json
        values = json['value'].inject({}) do |hash, kv|
          key, value = *kv
          hash[key.to_sym] = TermFactory.from_json(value)
          hash
        end

        new values
      end

      def initialize values
        @value = values.inject({}) do |mapped, kv|
          k,v = *kv
          mapped[k] = v.to_shokkenki_term
          mapped
        end

        @type = :hash
      end

      def to_hash
        mapped_values = @value.inject({}) do |mapped, keyvalue|
          key, value = *keyvalue
          mapped[key] = value.respond_to?(:to_hash) ? value.to_hash : value
          mapped
        end

        {
          :type => @type,
          :value => mapped_values
        }
      end

      def example
        @value.inject({}) do |hash, kv|
          key, value = *kv
          hash[key] = value.example
          hash
        end
      end

      def match? compare
        compare && @value.all? do |key, value|
          value.match? compare.to_hash[key]
        end
      end
    end
  end
end