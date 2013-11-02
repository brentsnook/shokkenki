require 'uri'
require 'net/http'
require 'rack'
require 'rack/handler/webrick'

# pinched from https://github.com/jnicklas/capybara/blob/master/lib/capybara/server.rb
module Shokkenki
  module Consumer
    module Stubber
      class Server

        attr_reader :app, :port, :host, :server_thread, :error

        def initialize attributes
          @app = attributes[:app]
          @server_thread = nil # suppress warnings
          @host = attributes[:host]
          @port = attributes[:port]
        end

        def error
          @app.error
        end

        def assert_ok!
          raise error if error
        end

        def responsive?
          return false if server_thread && server_thread.join(0)
          res = Net::HTTP.start(host, @port) do |http|
            http.get @app.identify_path
          end
          assert_ok!
          ok?(res) && is_app?(res)
        rescue SystemCallError
          return false
        end

        def is_app? response
          response.body.to_s == @app.object_id.to_s
        end

        def ok? response
          response.is_a?(Net::HTTPSuccess) or response.is_a?(Net::HTTPRedirection)
        end

        def run app, host, port
          Rack::Handler::WEBrick.run(app, :Host => host, :Port => port, :AccessLog => [], :Logger => WEBrick::Log::new(nil, 0))
        end

        def start
          @server_thread = Thread.new do
            run @app, @host, @port
          end

          Timeout.timeout(10) { @server_thread.join(0.1) until responsive? }
        rescue Timeout::Error
          raise "Rack application #{@app} timed out during boot"
        end

        def shutdown
          server_thread.kill
        end
      end
    end
  end
end