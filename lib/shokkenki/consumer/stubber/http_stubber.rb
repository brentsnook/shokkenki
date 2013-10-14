require 'httparty'
require 'uri'

module Shokkenki
  module Consumer
    module Stubber
      class HttpStubber

        attr_reader :interactions_url

        def initialize attributes
          @interactions_url = URI.parse(attributes[:interactions_url]).to_s
        end

        def stub_interaction interaction
          response = HTTParty.post(@interactions_url,
            :body => interaction.to_hash,
            :headers => { 'Content-Type' => 'application/json' }
          )
          raise "Failed to stub interaction: #{response.inspect}" unless successful?(response)
        end

        def clear_interaction_stubs
          response = HTTParty.delete @interactions_url
          raise "Failed to clear interaction stubs: #{response.inspect}" unless successful?(response)
        end

        def successful? response
          (200 <= response.code) &&  (response.code < 300)
        end

      end
    end
  end
end