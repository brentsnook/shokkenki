module Shokkenki
  module Provider
    module RSpec
      module StringTerm
        def verify_within context
          term_value = value
          context.it %Q{is "#{term_value}"} do
            expect(actual_value.to_s).to(eq(term_value))
          end
        end
      end
    end
  end
end