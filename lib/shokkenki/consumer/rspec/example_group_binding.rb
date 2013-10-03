require 'shokkenki/consumer/session'
require 'shokkenki/consumer/consumer_role'

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