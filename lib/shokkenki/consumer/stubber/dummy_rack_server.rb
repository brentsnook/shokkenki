# temporary rack server - just logs out requests

module Shokkenki
  module Consumer
    module Stubber
      class DummyRackServer
        def call env
          puts env.inspect
          [200, {}, ['done diddly']]
        end
      end
    end
  end
end