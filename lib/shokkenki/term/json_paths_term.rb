require 'jsonpath'
require 'active_support/core_ext/hash/deep_merge'
require 'json'
require_relative 'json_path_example'
require_relative 'term'
require_relative 'core_ext'

module Shokkenki
  module Term
    class JsonPathsTerm < Term

      attr_reader :type, :value

      def self.from_json json
        values = json['value'].inject({}) do |hash, kv|
          key, value = *kv
          hash[key] = TermFactory.from_json(value)
          hash
        end

        new values
      end

      def initialize values
        @value = values.inject({}) do |mapped, kv|
          k, v = *kv
          mapped[k] = v.to_shokkenki_term
          mapped
        end

        @type = :json_paths
      end

      def match? compare
        compare && @value.all? do |key, value|
          path = JsonPath.new(key)
          value.match? path.on(compare)
        end
      end

      def example
        @value.inject({}) do |generated, keyvalue|
          path, term = *keyvalue
          generated.deep_merge! JsonPathExample.new(path, term).to_example
          generated
        end.to_json
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

    end
  end
end