module Shokkenki
  module Consumer
    module Model
      class Interaction

        attr_reader :label, :request, :response, :time

        def initialize attributes
          @label = attributes[:label]
          @request = attributes[:request]
          @response = attributes[:response]
          @time = Time.now
        end

        def to_hash
          hash = {
            :request => @request.to_hash,
            :response => @response.to_hash,
            :time => @time.utc.iso8601
          }
          hash.merge!(:label => @label) if @label
        end
      end
    end
  end
end