module Shokkenki
  module Consumer
    module Stubber
      module Term
        class StringTerm

          attr_reader :value

          def self.from_json json
            new :value => json['value']
          end

          def initialize attributes
            @value = attributes[:value]
          end

          def example
            @value
          end

          def match? compare
            compare && (compare.strip == @value)
          end
        end
      end
    end
  end
end