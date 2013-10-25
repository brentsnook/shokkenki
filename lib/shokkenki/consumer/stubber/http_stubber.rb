require_relative 'server'
require_relative 'rack_server'
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
        end

        def stub_interaction interaction
          response = HTTParty.post(interactions_uri,
            :body => interaction.to_hash.to_json,
            :headers => { 'Content-Type' => 'application/json' }
          )
          raise "Failed to stub interaction: #{response.inspect}" unless successful?(response)
        end

        def clear_interaction_stubs
          response = HTTParty.delete interactions_uri
          raise "Failed to clear interaction stubs: #{response.inspect}" unless successful?(response)
        end

        def successful? response
          (200 <= response.code) &&  (response.code < 300)
        end

        def session_started
          # Find a port as late as possible to minimise the
          # chance that it starts being used in between finding it
          # and using it.
          @port = FindAPort.available_port unless @port

          @server = Server.new(
            :app => RackServer.new,
            :host => @host,
            :port => @port
          )
          @server.start
        end

        def session_closed
          @server.shutdown
        end

        def interactions_uri
          URI::Generic.build(
            :scheme => @scheme.to_s,
            :host => @host.to_s,
            :port => @port,
            :path => @interactions_path.to_s
          ).to_s
        end

      end
    end
  end
end