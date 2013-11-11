require 'rack/test'
require 'faraday'

module Shokkenki
  module Provider
    module Model
      class RackHttpClient

        def initialize app
          @connection = Faraday.new do |f|
            f.adapter :rack, app
          end
        end

        def response_for request_term
          request = request_term.example
          response = @connection.send(request.delete(:method).to_sym) do |r|
            request.each do |key, value|
              writer = (key == :query) ? :params= : "#{key}=".to_sym
              r.send writer, value
            end
          end

          as_shokkenki_response response
        end

        private

        def as_shokkenki_response response
          {
            :status => response.status,
            :headers => response.headers,
            :body => response.body
          }
        end
      end
    end
  end
end