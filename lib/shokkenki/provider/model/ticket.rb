require 'ostruct'

module Shokkenki
  module Provider
    module Model
      # At the moment this class is FITYMI
      class Ticket

        attr_reader :provider

        def initialize
          @provider = OpenStruct.new :name => :my_provider
        end
      end
    end
  end
end