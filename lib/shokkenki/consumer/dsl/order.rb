require 'shokkenki/term/core_ext'
require_relative '../model/interaction'
require_relative '../model/fixture'
require_relative 'http_methods'
require_relative 'term_dsl'

module Shokkenki
  module Consumer
    module DSL
      class Order
        include HttpMethods
        include TermDSL

        def initialize patronage
          @patronage = patronage
          @fixtures = []
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

        def given name, arguments=nil
          @fixtures << Shokkenki::Consumer::Model::Fixture.new(
            :name => name,
            :arguments => arguments
          )
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
            :response => @response_details.to_shokkenki_term,
            :fixtures => @fixtures
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