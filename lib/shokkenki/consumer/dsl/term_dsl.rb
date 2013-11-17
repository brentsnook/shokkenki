require_relative '../../term/json_paths_term'

module Shokkenki
  module Consumer
    module DSL
      module TermDSL
        def json paths
          Shokkenki::Term::JsonPathsTerm.new paths
        end
      end
    end
  end
end
