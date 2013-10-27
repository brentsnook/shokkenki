module Shokkenki
  module Term
    class AndExpressionTerm

      attr_reader :values

      def self.from_json json
        values = json['values'].inject({}) do |hash, kv|
          key, value = *kv
          hash[key.to_sym] = TermFactory.from_json(value)
          hash
        end

        new values
      end

      def initialize values
        @values = values
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
          value.match? compare[key]
        end
      end
    end
  end
end