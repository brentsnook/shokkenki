require_relative '../model/rack_http_client'

module Shokkenki
  module Provider
    module Configuration
      module Provider
        def run app
          self.http_client = Shokkenki::Provider::Model::RackHttpClient.new app
        end

        def given match, &block
          add_fixture match, block
        end
      end
    end
  end
end
