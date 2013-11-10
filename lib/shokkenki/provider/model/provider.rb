require_relative '../configuration/provider'

module Shokkenki
  module Provider
    module Model
      class Provider
        include Shokkenki::Provider::Configuration::Provider
        attr_reader :app, :name

        def initialize name
          @name = name
        end
      end
    end
  end
end