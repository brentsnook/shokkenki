require 'shokkenki/consumer/stubber/interactions'
require 'shokkenki/consumer/stubber/admin_middleware'
require 'shokkenki/consumer/stubber/stubbed_response_middleware'

module Shokkenki
  module Consumer
    module Stubber
      class RackServer

        def initialize
          @interactions = Shokkenki::Consumer::Stubber::Interactions.new
          @admin = Shokkenki::Consumer::Stubber::AdminMiddleware.new @interactions
          @stubbed_response = Shokkenki::Consumer::Stubber::StubbedResponseMiddleware.new @interactions
        end

        def call env
          handler = env['PATH_INFO'].match(%r{^/shokkenki/}) ? @admin : @stubbed_response
          handler.call env
        end
      end
    end
  end
end