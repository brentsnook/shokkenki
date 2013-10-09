module Shokkenki
  module Consumer
    module Term
      class StringTerm

        attr_reader :type, :value

        def initialize value
          @value = value.to_s
          @type = :string
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