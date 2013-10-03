module Shokkenki
  module Consumer
    module Simplification
      def simplify name
        name.to_s.
          strip.
          gsub(' ', '_').
          gsub(/\W/, '').
          downcase.
          to_sym if name
      end
    end
  end
end