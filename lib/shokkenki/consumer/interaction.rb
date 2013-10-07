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
    end
  end
end