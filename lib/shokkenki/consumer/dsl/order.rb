require 'shokkenki/consumer/interaction'

module Shokkenki
  module Consumer
    module DSL
      class Order

        attr_reader :provider_name

        def provider provider_name
          @provider_name = provider_name
        end

        def during label
          @interaction_label = label
        end

        def requested_with details
          @request_details = details
        end

        def responds_with details
          @response_details = details
        end

        def to_interaction
          Shokkenki::Consumer::Interaction.new(
            :label => @interaction_label,
            :request => Shokkenki::Consumer::Request.new(@request_details),
            :response => Shokkenki::Consumer::Response.new(@response_details)
          )
        end
      end
    end
  end
end