module Shokkenki
  module Term
    class JsonPathExample

      def initialize path, term
        @path = path
        @term = term
      end

      def to_example # FITYMI
        {
          :chatter => {
            :inane => @term.example
          }
        }
      end

      private

      def add_path_element example, path
        value = {}
        unless path.empty?
          element = path.shift
          example[element] = value
          add_path_element value, path
        end
      end
    end
  end
end