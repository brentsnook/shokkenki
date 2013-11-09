module Shokkenki
  module Provider
    module RSpec
      module AndExpressionTerm
        def verify_within context

          context.describe 'status' do
            it('is 200'){}
          end

          context.describe 'body' do
            it('matches /hello there/'){}
          end
        end
      end
    end
  end
end