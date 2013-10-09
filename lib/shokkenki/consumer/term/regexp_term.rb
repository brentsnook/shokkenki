module Shokkenki
  module Consumer
    module Term
      class RegexpTerm

        attr_reader :type, :value

        def initialize value
          @value = Regexp.new(value)
          @type = :regexp
        end

        def to_hash
          {
            :type => @type,
            :value => @value.to_s
          }
        end

      end
    end
  end
end