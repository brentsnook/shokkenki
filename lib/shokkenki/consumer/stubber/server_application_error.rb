module Shokkenki
  module Consumer
    module Stubber
      class ServerApplicationError < StandardError
        def initialize error
          super "An error occurred in the stub server: #{error.message}"
          @error = error
        end

        def set_backtrace backtrace
          super (@error.backtrace || []) + backtrace
        end
      end
    end
  end
end