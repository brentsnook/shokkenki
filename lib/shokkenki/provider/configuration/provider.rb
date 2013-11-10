require_relative '../model/rack_http_client'

module Shokkenki
  module Provider
    module Configuration
      module Provider
        def run app
          self.http_client = Shokkenki::Provider::Model::RackHttpClient.new app
        end
      end
    end
  end
end
