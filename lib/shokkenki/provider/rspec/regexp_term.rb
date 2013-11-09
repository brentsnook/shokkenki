module Shokkenki
  module Provider
    module RSpec
      module RegexpTerm
        def verify_within context
          term_value = value
          context.it %Q{matches /#{term_value}/} do
            expect(actual_value.to_s).to(match(term_value))
          end
        end
      end
    end
  end
end