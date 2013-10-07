module Shokkenki
  module Consumer
    class Request

      attr_reader :method_type, :path

      def initialize attributes
        @method_type = attributes[:method]
        @path = attributes[:path]
      end

    end
  end
end