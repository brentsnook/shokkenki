module Shokkenki
  module Consumer
    module Stubber
      class Interactions

        attr_reader :interactions, :requests

        def initialize
          @interactions = []
          @requests = []
        end

        def find request
          matching_interaction = @interactions.find do |interaction|
            interaction.match_request? request
          end
          request.interaction = matching_interaction if matching_interaction
          @requests << request
          matching_interaction
        end

        def delete_all
          @interactions.clear
          @requests.clear
        end

        def add interaction
          @interactions << interaction
        end

        def unmatched_requests
          @requests.select{ |r| r.interaction.nil? }
        end
      end
    end
  end
end