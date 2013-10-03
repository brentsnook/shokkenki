require 'json'
require 'time'

module Shokkenki
  module Consumer
    class Ticket

      attr_reader :provider, :consumer
      attr_accessor :time, :version

      def initialize attributes
        @provider = attributes[:provider]
        @consumer = attributes[:consumer]
      end

      def filename
        "#{@consumer}-#{@provider}.json"
      end

      def to_hash
        {
          :consumer => {
            :name => @consumer
          },
          :provider => {
            :name => @provider
          },
          :time => @time.utc.iso8601,
          :version => @version
        }
      end

      def to_json
        to_hash.to_json
      end
    end
  end
end