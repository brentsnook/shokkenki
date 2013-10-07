require 'shokkenki/consumer/dsl/order'

module Shokkenki
  module Consumer
    module DSL
      module Session
        def order &block
          order = Shokkenki::Consumer::DSL::Order.new
          order.instance_eval &block
          current_patronage_for(order.provider_name).add_interaction order.to_interaction
        end
      end
    end
  end
end