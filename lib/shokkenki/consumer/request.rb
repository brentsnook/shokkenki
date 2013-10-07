module Shokkenki
  module Consumer
    class Request

      attr_reader :method_type, :path

      def initialize attributes
        @method_type = attributes[:method]
        @path = attributes[:path]
      end

      def to_hash
        {
          :method => @method_type,
          :path => @path
        }
      end
    end
  end
end