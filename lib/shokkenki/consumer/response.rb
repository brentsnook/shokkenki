module Shokkenki
  module Consumer
    class Response

      attr_reader :body

      def initialize attributes
        @body = attributes[:body] if attributes
      end

    end
  end
end