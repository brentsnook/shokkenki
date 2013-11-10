module Shokkenki
  module Provider
    module RSpec
      module AndExpressionTerm
        def verify_within context
          values.each do |name, term|
            context.describe name do
              before { @actual_value = @actual_values[name] }

              term.verify_within self
            end
          end
        end
      end
    end
  end
end