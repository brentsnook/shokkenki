require 'shokkenki/consumer/request'
require 'shokkenki/consumer/response'

module Shokkenki
  module Consumer
    class Interaction

      attr_reader :label, :request, :response

      def initialize attributes
        @label = attributes[:label]
      end

      def requested_with request_attributes
        @request = Shokkenki::Consumer::Request.new request_attributes
      end

      def responds_with response_attributes
        @response = Shokkenki::Consumer::Response.new response_attributes
      end

    end
  end
end