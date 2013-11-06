require_relative '../spec_helper'
require 'json'
require 'tmpdir'

# 'let' can't be used from before(:all)
ticket_directory = File.join(File.dirname(__FILE__), 'tickets')

describe 'A provider rspec spec' do

  context 'after a provider consumer example is run' do
    let(:spec_output) { run_spec 'spec/integration/provider/provider_rspec_spec_harness.rb -f documentation --no-color', 'ticket_directory' => ticket_directory }
    it 'will define and execute examples for the ticket' do
      output = <<-OUTPUT
My Consumer
  greeting
    status
      is 200
    body
      matches /hello there/
OUTPUT

      expect(spec_output.strip).to start_with(output.strip)
    end
  end
end