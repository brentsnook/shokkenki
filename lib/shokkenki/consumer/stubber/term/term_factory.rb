module Shokkenki
  module Consumer
    module Stubber
      module Term
        class TermFactory

          def self.from_json json
            new
          end

          def example
            {
              :status => 200,
              :body => 'hello kitty'
            }
          end

          def match? value
            true
          end
        end
      end
    end
  end
end