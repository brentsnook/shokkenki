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

      describe 'interaction' do

        let(:interaction) { ticket['interactions'].first }

        it 'includes the label' do
          expect(interaction['label']).to eq('a greeting')
        end

        it 'includes the request term' do
          expect(interaction['request']).to(include(
            {
              'type' => 'and_expression',
              'values' => {
                'path' => {
                  'type' => 'string',
                  'value' => '/greeting'
                }
              }
            }
          ))
        end

        it 'includes the response term' do
          expect(interaction['response']).to(include(
            {
              'type' => 'and_expression',
              'values' => {
                'body' => {
                  'type' => 'regexp',
                  'value' => '(?-mix:hello)'
                }
              }
            }
          ))
        end
      end
    end
  end
end