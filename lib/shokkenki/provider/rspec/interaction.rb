module Shokkenki
  module Provider
    module RSpec
      module Interaction

        def verify_within context
          context.describe label do
            describe 'status' do
              it('is 200'){}
            end
            describe 'body' do
              it('matches /hello there/'){}
            end
          end
        end
      end
    end
  end
end