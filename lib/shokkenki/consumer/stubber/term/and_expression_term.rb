module Shokkenki
  module Consumer
    module Stubber
      module Term
        class AndExpressionTerm

          attr_reader :values

          def self.from_json json
            values = json['values'].inject({}) do |hash, kv|
              key, value = *kv
              hash[key.to_sym] = TermFactory.from_json(value)
              hash
            end

            new :values => values
          end

          def initialize attributes
            @values = attributes[:values]
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
  end
end