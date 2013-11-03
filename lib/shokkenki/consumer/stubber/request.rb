require 'uri'

module Shokkenki
  module Consumer
    module Stubber
      class Request

        attr_reader :path, :method, :body, :query, :headers

        def self.from_rack rack_env
          env = rack_env.dup
          new(
            :path => env['PATH_INFO'],
            :method => env['REQUEST_METHOD'].downcase,
            :body => env['rack.input'].read,
            :query => query_from(env['QUERY_STRING']),
            :headers => headers_from(env)
          )
        end

        def initialize attributes
          @path = attributes[:path]
          @method = attributes[:method]
          @body = attributes[:body]
          @query = attributes[:query]
          @headers = attributes[:headers]
        end

        def to_hash
          {
            :path => @path,
            :method => @method,
            :headers => @headers,
            :query => @query,
            :body => @body
          }
        end

        def self.headers_from env
          env.reject{ |k, v|
            [
              'PATH_INFO',
              'REQUEST_METHOD',
              'QUERY_STRING'
            ].include?(k)
          }.
          reject { |k, v| k.start_with?('rack.') }.
          reject { |k, v| k.start_with?('async.') }.
          inject({}) do |headers, key_value|
            headers[as_header_name(key_value[0])] = key_value[1]
            headers
          end
        end

        def self.query_from query_string
          query_string.split('&').inject({}) do |query, param|
            k, v = param.split '='
            query[k.to_sym] = URI.decode v
            query
          end
        end

        def self.as_header_name name
          name.to_s.gsub(/^HTTP_/, '').gsub('_', '-').downcase.to_sym
        end
      end
    end
  end
end