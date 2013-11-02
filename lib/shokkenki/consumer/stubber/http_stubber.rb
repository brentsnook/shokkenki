require_relative 'server'
require_relative 'stub_server_middleware'
require 'httparty'
require 'uri'
require 'find_a_port'

module Shokkenki
  module Consumer
    module Stubber
      class HttpStubber

        attr_reader :port, :host, :scheme, :interactions_path, :server

        def initialize attributes
          @port = attributes[:port]
          @scheme = attributes[:scheme] || :http
          @host = attributes[:host] || 'localhost'
          @interactions_path = attributes[:interactions_path] || '/shokkenki/interactions'
          @unmatched_requests_path = '/shokkenki/requests/unmatched'
        end

        def stub_interaction interaction
          response = HTTParty.post(interactions_uri,
            :body => interaction.to_hash.to_json,
            :headers => { 'Content-Type' => 'application/json' }
          )
          server.assert_ok!
          raise "Failed to stub interaction: #{response.inspect}" unless successful?(response.code)
        end

        def clear_interaction_stubs
          response = HTTParty.delete interactions_uri
          server.assert_ok!
          raise "Failed to clear interaction stubs: #{response.inspect}" unless successful?(response.code)
        end

        def successful? response_code
          (200 <= response_code) &&  (response_code < 300)
        end

        def session_started
          # Find a port as late as possible to minimise the
          # chance that it starts being used in between finding it
          # and using it.
          @port = FindAPort.available_port unless @port

          @server = Server.new(
            :app => StubServerMiddleware.new,
            :host => @host,
            :port => @port
          )
          @server.start
        end

        def session_closed
          @server.shutdown
        end

        def unmatched_requests
          response = HTTParty.get unmatched_requests_uri
          server.assert_ok!
          raise "Failed to find unmatched requests: #{response.inspect}" unless successful?(response.code)
          JSON.parse response.body
        end

        def server_properties
          {
            :scheme => @scheme.to_s,
            :host => @host.to_s,
            :port => @port
          }
        end

        def interactions_uri
          URI::Generic.build(server_properties.merge(:path => @interactions_path.to_s)).to_s
        end

        def unmatched_requests_uri
          URI::Generic.build(server_properties.merge(:path => @unmatched_requests_path.to_s)).to_s
        end

      end
    end
  end
end