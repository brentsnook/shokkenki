require 'shokkenki/consumer/model/interaction'

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

        def validate!
          raise "No 'provider' has been specified." unless @provider_name
          raise "No 'during' has been specified." unless @interaction_label
          raise "No 'requested_with' has been specified." unless @request_details
          raise "No 'responds_with' has been specified." unless @response_details
        end

        def to_interaction
          Shokkenki::Consumer::Model::Interaction.new(
            :label => @interaction_label,
            :request => @request_details.to_shokkenki_term,
            :response => @response_details.to_shokkenki_term
          )
        end
      end
    end
  end
end