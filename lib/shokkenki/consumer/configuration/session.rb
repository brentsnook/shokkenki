require 'shokkenki/consumer/configuration/provider_configuration'
require 'shokkenki/consumer/stubber/http_stubber'

module Shokkenki
  module Consumer
    module Configuration
      module Session

        attr_reader :stubber_classes

        def configure
          yield self if block_given?
        end

        def stubber_classes
          @stubber_classes ||= { :local_server => Shokkenki::Consumer::Stubber::HttpStubber }
        end

        def register_stubber name, clazz
          stubber_classes[name] = clazz
        end

        def add_provider name
          provider_config = ProviderConfiguration.new(
            name,
            stubber_classes
          )
          yield provider_config
          provider_config.validate!
          provider provider_config.to_attributes
        end
      end
    end
  end
end