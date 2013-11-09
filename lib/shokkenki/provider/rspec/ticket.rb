require 'rspec/core/dsl'

module Shokkenki
  module Provider
    module RSpec
      module Ticket
        include ::RSpec::Core::DSL

        def verify_with provider
          ticket = self
          describe consumer.label do
            ticket.interactions.each { |i| i.verify_within self }
          end
        end
      end
    end
  end
end