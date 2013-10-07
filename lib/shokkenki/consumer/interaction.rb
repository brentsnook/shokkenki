require 'shokkenki/consumer/request'
require 'shokkenki/consumer/response'

module Shokkenki
  module Consumer
    class Interaction

      attr_reader :label, :request, :response, :time

      def initialize attributes
        @label = attributes[:label]
        @request = attributes[:request]
        @response = attributes[:response]
        @time = Time.now
      end

      def to_hash
        {
          :label => @label,
          :request => @request.to_hash,
          :response => @response.to_hash,
          :time => @time.utc.iso8601
        }
      end
    end
  end
end