require 'shokkenki/consumer/provider_role'

module Shokkenki
  module Consumer
    class ConsumerRole

      attr_reader :name, :providers

      def initialize arguments
        @name = arguments[:name]
        @providers = {}
      end

      def provider provider_name
        @providers[provider_name] ||= Shokkenki::Consumer::ProviderRole.new :name => provider_name, :consumer => self
      end

      def tickets
        @providers.values.collect &:ticket
      end

    end
  end
end