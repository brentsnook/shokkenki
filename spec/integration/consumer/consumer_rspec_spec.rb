require_relative '../spec_helper'
require 'json'
require 'tmpdir'

# 'let' can't be used from before(:all)
ticket_directory = Dir.mktmpdir 'shokkenki-integration-spec-tickets'

describe 'A consumer rspec spec' do

  context 'after a shokkenki consumer example is run' do

    # careful with before(:all)! note that this runs once for the entire group
    # running the command each time is quite slow
    before(:all) do
      run_spec 'spec/integration/consumer/consumer_rspec_spec_harness.rb -f progress', 'ticket_directory' => ticket_directory
    end

    describe "the created ticket found in #{ticket_directory}" do

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
                'method' => {
                  'type' => 'string',
                  'value' => 'get'
                },
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
                'status' => {
                  'type' => 'number',
                  'value' => 200,
                },
                'body' => {
                  'type' => 'regexp',
                  'value' => '(?-mix:hello there, its a warm one today )'
                }
              }
            }
          ))
        end

        describe 'fixtures' do

          let(:fixture) { interaction['fixtures'].first }

          it 'includes the fixture name' do
            expect(fixture['name']).to eq('weather')
          end

          it 'includes the fixture arguments' do
            expect(fixture['arguments']).to eq('temperature' => 30)
          end

        end
      end
    end
  end
end