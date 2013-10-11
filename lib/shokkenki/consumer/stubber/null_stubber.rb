module Shokkenki
  module Consumer
    module Stubber
      class NullStubber
        def stub_interaction interaction
          warn
        end

        private

        def warn
          message = <<-EOM
A provider has no stubber configured.
Please see the documention for how to configure stubbers.
EOM
          puts message
        end
      end
    end
  end
end