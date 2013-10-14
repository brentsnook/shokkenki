module Shokkenki
  module Consumer
    module Configuration
      module Session
        def configure
          yield self if block_given?
        end
      end
    end
  end
end