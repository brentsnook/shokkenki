require_relative 'provider_configuration'
require_relative '../stubber/http_stubber'

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

        def define_provider name
          provider_config = ProviderConfiguration.new(
            name,
            stubber_classes
          )
          yield provider_config
          provider_config.validate!
          add_provider provider_config.to_provider
        end
      end
    end
  end
end