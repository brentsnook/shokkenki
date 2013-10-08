require 'shokkenki/consumer/session'

module Shokkenki
  module Consumer
    module RSpec
      module ExampleGroupBinding
        def shokkenki
          Shokkenki::Consumer::Session.singleton
        end
      end
    end
  end
end