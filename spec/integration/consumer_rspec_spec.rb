require_relative 'spec_helper'
require 'json'
require 'tmpdir'

describe 'A consumer rspec spec' do

  let(:ticket_directory) do
    Dir.mktmpdir 'shokkenki-integration-spec-tickets'
  end

  context 'after a shokkenki consumer example is run' do

    before do
      run_spec 'spec/integration/consumer_rspec_spec_harness.rb', 'ticket_directory' => ticket_directory
    end

  	describe 'the created ticket' do

      let(:ticket) do
        JSON.parse File.read(File.expand_path(File.join(ticket_directory, 'my_consumer-my_provider.json')))
      end

      it 'includes the consumer name' do
        expect(ticket['consumer']['name']).to eq('my_consumer')
  	  end

      it 'includes the provider name' do
        expect(ticket['provider']['name']).to eq('my_provider')
      end
    end
  end
end