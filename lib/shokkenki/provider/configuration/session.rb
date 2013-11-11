require_relative '../model/provider'

module Shokkenki
  module Provider
    module Configuration
      module Session

        def configure &block
          instance_eval &block
        end

        def tickets location
          self.ticket_location = location
        end

        def provider name, &block
          provider = Shokkenki::Provider::Model::Provider.new(name)
          provider.instance_eval &block if block
          add_provider provider
        end
      end
    end
  end
end