require_relative '../configuration/provider'
require_relative 'fixture'

module Shokkenki
  module Provider
    module Model
      class Provider
        include Shokkenki::Provider::Configuration::Provider
        attr_reader :name, :fixtures
        attr_accessor :http_client

        def initialize name
          @name = name
          @fixtures = []
        end

        def add_fixture name_pattern, fixture
          @fixtures << Fixture.new(name_pattern, fixture)
        end

        def establish required_fixtures
          required_fixtures.each do |required_fixture|
            @fixtures.each { |fixture| fixture.establish required_fixture }
          end
        end
      end
    end
  end
end