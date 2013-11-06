require 'rspec/core/dsl'

module Shokkenki
  module Provider
    class Session
      include RSpec::Core::DSL

      def honour_tickets
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