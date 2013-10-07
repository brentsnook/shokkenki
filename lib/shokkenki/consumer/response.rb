module Shokkenki
  module Consumer
    class Response

      attr_reader :body

      def initialize attributes
        @body = attributes[:body] if attributes
      end

      def to_hash
        {
          :body => @body
        }
      end

    end
  end
end