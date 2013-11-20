require 'jsonpath'

module Shokkenki
  module Term
    class JsonPathExample

      ELEMENT_HANDLERS = {
        /^\['(.+)'\]$/ => lambda{ |match, ancestor, value| ancestor[match[1]] = value },
        /\*/ => lambda{ |m, a, v| a['wildcard'] = v },
        /\.\./ => lambda{ |m, a, v| a },
        /\$/ => lambda{ |m, a, v| a }, # ignore root element
        /^\[\d+\]$/ => lambda{ |m, a, v| raise "Numeric element '#{m[0]}' is not supported."},
        /^\[\?.*\]$/ => lambda{ |m, a, v| raise "Filter element '#{m[0]}' is not supported."},
        /^\[.*,.*\]$/ => lambda{ |m, a, v| raise "Union element '#{m[0]}' is not supported."},
        /^\[.*:.*\]$/ => lambda{ |m, a, v| raise "Array slice element '#{m[0]}' is not supported."},
        /^\[.*\(.*\]$/ => lambda{ |m, a, v| raise "Script element '#{m[0]}' is not supported."},
        /.*/ => lambda{ |m, a, v| raise "Unrecognised element '#{m[0]}' is not supported."}
      }

      def initialize path, term
        @path = path
        @term = term
      end

      def to_example
        example = {}
        path = JsonPath.new(@path).path
        last = path.pop

        begin
          leaf = path.inject(example) do |ancestor, element|
            store ancestor, element
          end

          store leaf, last, @term.example
        rescue Exception => e
          raise "Could not generate example for JSON path '#{@path}': #{e.message}"
        end

        example
      end

      private

      def store ancestor, element, value={}
        pattern, handler = ELEMENT_HANDLERS.find do |p, h|
          p.match element
        end

        handler.call pattern.match(element), ancestor, value
      end
    end
  end
end