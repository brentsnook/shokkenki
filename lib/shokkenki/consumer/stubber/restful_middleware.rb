module Shokkenki
  module Consumer
    module Stubber
      class RestfulMiddleware

        def self.post &block
          handlers[:post] = block
        end

        def self.delete &block
          handlers[:delete] = block
        end

        def self.get &block
          handlers[:get] = block
        end

        def self.handlers
          @handlers ||= {}
        end

        def call env
          handler = self.class.handlers[env['REQUEST_METHOD'].downcase.to_sym]
          handler ? instance_exec(env, &handler) : [405, {'Allow' => allowed_methods.join(', ')}, []]
        end

        def allowed_methods
          self.class.handlers.keys.map {|k| k.to_s.upcase }
        end
      end
    end
  end
end