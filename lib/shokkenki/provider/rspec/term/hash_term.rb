module Shokkenki
  module Provider
    module RSpec
      module Term
        module HashTerm
          def verify_within context
            values.each do |name, term|
              context.describe name do
                before { @actual_values = @actual_values.map{ |value| value[name] } }

                term.verify_within self
              end
            end
          end
        end
      end
    end
  end
end