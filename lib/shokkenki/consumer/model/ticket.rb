require_relative '../../version'
require 'json'

module Shokkenki
  module Consumer
    module Model
      class Ticket

        attr_reader :provider, :consumer, :interactions
        attr_accessor :time, :version

        def initialize attributes
          @provider = attributes[:provider]
          @consumer = attributes[:consumer]
          @interactions = attributes[:interactions]
          @version = Shokkenki::Version::STRING
        end

        def filename
          "#{@consumer.name}-#{@provider.name}.json"
        end

        def to_hash
          {
            :consumer => @consumer.to_hash,
            :provider => @provider.to_hash,
            :interactions => @interactions.collect(&:to_hash),
            :version => @version
          }
        end

        def to_json
          JSON.pretty_generate to_hash
        end
      end
    end
  end
end