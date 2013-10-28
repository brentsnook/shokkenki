require_relative '../model/interaction'

module Shokkenki
  module Consumer
    module DSL
      class Order

        def initialize patronage
          @patronage = patronage
        end

        def during label
          @interaction_label = label
          self
        end

        def receive details
          @request_details = details
          self
        end

        def and_respond details
          @response_details = details
          self
        end

        def validate!
          raise "No 'receive' has been specified." unless @request_details
          raise "No 'and_respond' has been specified." unless @response_details
        end

        def to_interaction
          Shokkenki::Consumer::Model::Interaction.new(
            :label => @interaction_label,
            :request => @request_details.to_shokkenki_term,
            :response => @response_details.to_shokkenki_term
          )
        end

        def to &block
          instance_eval &block
          validate!
          @patronage.add_interaction to_interaction
        end
      end
    end
  end
end