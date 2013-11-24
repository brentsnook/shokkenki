module Shokkenki
  module Provider
    module RSpec
      module Term
        module StringTerm
          def verify_within context
            term_value = value
            context.it %Q{is "#{term_value}"} do
              @actual_values.each { |value| expect(value.to_s).to(eq(term_value)) }
            end
          end
        end
      end
    end
  end
end