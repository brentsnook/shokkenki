module Shokkenki
  module Consumer
    module DSL
      module HttpMethods

        [:get, :put, :post, :delete, :options, :head].each do |meth|

          define_method meth do |path, details={}|
            receive({:path => path, :method => meth}.merge(details))
          end
        end

      end
    end
  end
end