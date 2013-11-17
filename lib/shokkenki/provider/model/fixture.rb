module Shokkenki
  module Provider
    module Model
      class Fixture

        def initialize name_pattern, establisher
          @name_pattern = name_pattern
          @establisher = establisher
          validate!
        end

        def establish required_fixture
          match = @name_pattern.match required_fixture.name
          if match
            arguments = {
              :arguments => required_fixture.arguments,
              :match => match
            }
            @establisher.call arguments
          end
        end

        private

        def validate!
          message = "Fixture establisher for name pattern /#{@name_pattern}/ must only accept zero or one argument."
          raise message unless @establisher.arity <= 1
        end

      end
    end
  end
end