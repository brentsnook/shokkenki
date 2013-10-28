require_relative 'order'

module Shokkenki
  module Consumer
    module DSL
      module Session
        def order provider_name
          order = Order.new current_patronage_for(provider_name)
        end
      end
    end
  end
end