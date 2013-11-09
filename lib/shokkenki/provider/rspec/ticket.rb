require 'rspec/core/dsl'

module Shokkenki
  module Provider
    module RSpec
      module Ticket
        include ::RSpec::Core::DSL

        def verify_with provider
          describe 'My Consumer' do
            describe 'greeting' do
              describe 'status' do
                it('is 200'){}
              end
              describe 'body' do
                it('matches /hello there/'){}
              end
            end
          end
        end
      end
    end
  end
end