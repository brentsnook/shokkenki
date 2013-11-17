module Shokkenki
  module Provider
    module RSpec
      module Interaction

        def verify_within context
          interaction = self
          context.describe label do
            before(:all) do
              @provider.establish interaction.required_fixtures

              @http_response = @provider.http_client.response_for(interaction.request)
            end
            before(:each) { @actual_values = @http_response }
            interaction.response.verify_within self
          end
        end

      end
    end
  end
end