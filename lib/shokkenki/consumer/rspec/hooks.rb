require_relative '../../shokkenki'
require_relative '../model/role'

module Shokkenki
  module Consumer
    module RSpec
      class Hooks

        def self.before_suite
          Shokkenki.consumer.start
        end

        def self.before_each metadata
          name = metadata[:name]
          Shokkenki.consumer.add_consumer(Shokkenki::Consumer::Model::Role.new(metadata)) unless Shokkenki.consumer.consumer(name)
          Shokkenki.consumer.set_current_consumer name
          Shokkenki.consumer.clear_interaction_stubs
        end

        def self.after_each
          Shokkenki.consumer.assert_all_requests_matched!
          Shokkenki.consumer.assert_all_interactions_used!
        end

        def self.after_suite
          Shokkenki.consumer.print_tickets
          Shokkenki.consumer.close
        end

      end
    end
  end
end