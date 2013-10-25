module Shokkenki
  module Consumer
    module Stubber
      module Term
        class StringTerm

          def self.from_json json
            new
          end

          def example
            raise 'kaboom'
          end

          def match? value
            raise 'kaboom'
          end
        end
      end
    end
  end
end