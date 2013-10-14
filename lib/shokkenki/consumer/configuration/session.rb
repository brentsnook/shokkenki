module Shokkenki
  module Consumer
    module Configuration
      module Session
        attr_accessor :ticket_location

        def configure
          yield self if block_given?
        end
      end
    end
  end
end