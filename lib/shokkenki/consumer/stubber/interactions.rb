module Shokkenki
  module Consumer
    module Stubber
      class Interactions

        attr_reader :interactions

        def initialize
          @interactions = []
        end

        def find request
          @interactions.find do |interaction|
            interaction.match_request? request
          end
        end

        def delete_all
          @interactions.clear
        end

        def add interaction
          @interactions << interaction
        end

        def requests
          []
        end
      end
    end
  end
end