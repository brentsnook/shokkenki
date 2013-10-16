require 'shokkenki/consumer/stubber/admin_middleware'
require 'shokkenki/consumer/stubber/stubbed_response_middleware'

module Shokkenki
  module Consumer
    module Stubber
      class RackServer

        def initialize
          @admin = Shokkenki::Consumer::Stubber::AdminMiddleware.new
          @stubbed_response = Shokkenki::Consumer::Stubber::StubbedResponseMiddleware.new
        end

        def call env
          handler = env['PATH_INFO'].match(%r{^/shokkenki/}) ? @admin : @stubbed_response
          handler.call env
        end
      end
    end
  end
end