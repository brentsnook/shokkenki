require_relative '../model/provider'

module Shokkenki
  module Consumer
    module Configuration
      class ProviderConfiguration

        attr_writer :label

        def initialize name, stubber_classes
          @name = name
          @stubber_classes = stubber_classes
        end

        def stub_with stubber_name, attributes = {}
          stubber_class = @stubber_classes[stubber_name] || raise("No stubber found named '#{stubber_name}'.")
          @stubber = stubber_class.new attributes
        end

        def validate!
          raise "No 'stub_with' has been specified." unless @stubber
        end

        def to_provider
          Shokkenki::Consumer::Model::Provider.new(
            :stubber => @stubber,
            :name => @name,
            :label => @label
          )
        end
      end
    end
  end
end
