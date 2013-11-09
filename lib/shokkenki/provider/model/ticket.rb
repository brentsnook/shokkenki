require 'ostruct'

module Shokkenki
  module Provider
    module Model

      # At the moment this class is FITYMI
      class Ticket

        attr_reader :provider, :interactions, :consumer

        def initialize
          @provider = OpenStruct.new :name => :my_provider
          @consumer = OpenStruct.new :label => 'My Consumer'
          @interactions = [ Interaction.new ]
        end
      end
    end
  end
end