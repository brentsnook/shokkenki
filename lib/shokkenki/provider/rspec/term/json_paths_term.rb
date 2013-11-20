require 'jsonpath'

module Shokkenki
  module Provider
    module RSpec
      module Term
        module JsonPathsTerm
          def verify_within context
            term = self
            context.describe 'json value' do
              term.values.each do |json_path, term|
                describe json_path do
                  before(:each) { @actual_value = JsonPath.on(@actual_value, json_path) }
                  term.verify_within self
                end
              end
            end
          end
        end
      end
    end
  end
end