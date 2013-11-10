require_relative '../configuration/provider'

module Shokkenki
  module Provider
    module Model
      class Provider
        include Shokkenki::Provider::Configuration::Provider
        attr_reader :name
        attr_accessor :http_client

        def initialize name
          @name = name
        end

      end
    end
  end
end