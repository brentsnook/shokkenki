require 'httparty'
require 'uri'

module Shokkenki
  module Consumer
    module Stubber
      class HttpStubber

        attr_reader :port, :host, :scheme, :interactions_path

        def initialize attributes
          @port = attributes[:port]
          @scheme = attributes[:scheme] || :http
          @host = attributes[:host] || 'localhost'
          @interactions_path = attributes[:interactions_path] || '/shokkenki/interactions'
        end

        def stub_interaction interaction
          response = HTTParty.post(interactions_uri,
            :body => interaction.to_hash,
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