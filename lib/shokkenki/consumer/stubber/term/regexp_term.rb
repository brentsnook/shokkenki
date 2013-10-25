module Shokkenki
  module Consumer
    module Stubber
      module Term
        class RegexpTerm

          def self.from_json json
            new
          end

          def example
            'hello kitty'
          end

          def match? compare
            true
          end

        end
      end
    end
  end
end