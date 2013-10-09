module Shokkenki
  module Consumer
    module Term
      class AndExpressionTerm

        attr_reader :type, :values

        def initialize values
          @values = values.to_hash.inject({}) do |mapped, keyvalue|
            key, value = *keyvalue
            mapped[key] = value.to_shokkenki_term
            mapped
          end
          @type = :and_expression
        end

        def to_hash
          mapped_values = @values.inject({}) do |mapped, keyvalue|
            key, value = *keyvalue
            mapped[key] = value.respond_to?(:to_hash) ? value.to_hash : value
            mapped
          end

          {
            :type => @type,
            :values => mapped_values
          }
        end

      end
    end
  end
end