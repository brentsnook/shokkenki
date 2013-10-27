require_relative 'order'

module Shokkenki
  module Consumer
    module DSL
      module Session
        def order provider_name
          order = Order.new provider_name, current_patronage_for(provider_name)
        end
      end
    end
  end
end