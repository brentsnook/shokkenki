require 'active_support/core_ext/string/inflections'

module Shokkenki
  module Consumer
    module Stubber
      class RackResponse

        def self.from_interaction interaction
          defaults = { :status => 200 }
          response = defaults.merge interaction.generate_response
          [response[:status], as_rack_headers(response[:headers]), [response[:body]]]
        end

        def self.as_rack_headers headers
          (headers || []).inject({}) do |h, key_value|
            k, v = key_value
            h[as_header_name(k)] = v.to_s
            h
          end
        end

        def self.as_header_name name
          name.to_s.split('-').map{ |word| word.titleize }.join('-')
        end
      end
    end
  end
end