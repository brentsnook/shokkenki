require_relative 'interactions'
require_relative 'interactions_middleware'
require_relative 'stubbed_response_middleware'

# adapted from middleware in https://github.com/jnicklas/capybara/blob/master/lib/capybara/server.rb
module Shokkenki
  module Consumer
    module Stubber
      class StubServerMiddleware

        attr_accessor :error

        def initialize
          @interactions = Interactions.new
          @middlewares = {
            %r{^#{identify_path}} => lambda(&method(:identify)),
            %r{^/shokkenki/} => InteractionsMiddleware.new(@interactions),
            /.*/ => StubbedResponseMiddleware.new(@interactions)
          }
        end

        def call env
          begin
            handler = @middlewares.find {|path, m| path.match(env['PATH_INFO']) }[1]
            handler.call env
          rescue StandardError => e
            @error = e unless @error
            raise e
          end
        end

        def identify env
          [200, {}, [object_id.to_s]]
        end

        def identify_path
          '/shokkenki/__identify__'
        end
      end
    end
  end
end