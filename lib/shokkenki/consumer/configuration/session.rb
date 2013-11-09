require_relative 'provider_configuration'
require_relative '../stubber/http_stubber'

module Shokkenki
  module Consumer
    module Configuration
      module Session

        attr_reader :stubber_classes

        def configure &block
          instance_eval &block if block
        end

        def tickets location
          self.ticket_location = location
        end

        def stubber_classes
          @stubber_classes ||= { :local_server => Shokkenki::Consumer::Stubber::HttpStubber }
        end

        def register_stubber name, clazz
          stubber_classes[name] = clazz
        end

        def define_provider name, &block
          provider_config = ProviderConfiguration.new(
            name,
            stubber_classes
          )
          provider_config.instance_eval &block if block
          add_provider provider_config.to_provider
        end
      end
    end
  end
end