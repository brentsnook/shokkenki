module Shokkenki
  module Provider
    module RSpec
      module Interaction

        def verify_within context
          interaction = self
          context.describe label do
            let(:actual_values) { {:body => 'hello there', :status => 200} }
            interaction.response.verify_within self
          end
        end

      end
    end
  end
end