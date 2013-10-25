module Shokkenki
  module Consumer
    module Term
      class NumberTerm
        attr_reader :type, :value

        def initialize value
          @value = value
          @type = :number
        end

        def to_hash
          {
            :type => @type,
            :value => @value
          }
        end

      end
    end
  end
end