# pinched from https://github.com/jnicklas/capybara/blob/master/lib/capybara/server.rb
module Shokkenki
  module Consumer
    module Stubber
      class Middleware

        IDENTIFY_PATH = '/shokkenki/__identify__'

        attr_accessor :error

        def initialize(app)
          @app = app
        end

        def call(env)
          if env['PATH_INFO'] == IDENTIFY_PATH
            [200, {}, [@app.object_id.to_s]]
          else
            begin
              @app.call(env)
            rescue StandardError => e
              @error = e unless @error
              raise e
            end
          end
        end
      end
    end
  end
end