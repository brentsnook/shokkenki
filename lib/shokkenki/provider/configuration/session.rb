require_relative 'provider_configuration'

module Shokkenki
  module Provider
    module Configuration
      module Session

        def tickets location
          self.ticket_location = location
        end

        def provider name, &block
          provider = ProviderConfiguration.new(name)
          provider.instance_eval &block if block
          add_provider provider
        end
      end
    end
  end
end