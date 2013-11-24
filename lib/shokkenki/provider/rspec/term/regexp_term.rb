module Shokkenki
  module Provider
    module RSpec
      module Term
        module RegexpTerm
          def verify_within context
            term_value = value
            context.it %Q{matches /#{term_value}/} do
              @actual_values.each{ |value| expect(value.to_s).to(match(term_value)) }
            end
          end
        end
      end
    end
  end
end