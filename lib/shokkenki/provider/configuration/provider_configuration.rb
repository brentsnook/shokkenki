module Shokkenki
  module Provider
    module Configuration
      class ProviderConfiguration

        attr_reader :app, :name

        def initialize name
          @name = name
        end

        def run app
          @app = app
        end
      end
    end
  end
end
