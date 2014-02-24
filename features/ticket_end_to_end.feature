Feature: Shokkenki ticket - end to end

  A ticket represents the contract between the consumer and the provider in [consumer-driven contracts](http://martinfowler.com/articles/consumerDrivenContracts.html).

  A ticket is defined by the consumer and can then be used by the provider to verify that it is behaving as the consumer expects.

  Scenario: Consumer defines a ticket and provider honours it
    Given a file named "spec/consumer_spec.rb" with:
      """ruby
     require 'shokkenki/consumer/rspec'
     require 'json'

      Shokkenki.consumer.configure do
        define_provider :my_provider
      end

      describe 'My Consumer', :shokkenki_consumer do

        before do
          order(:my_provider).
          during('greeting').to do
            given('greeter is happy').
            get('/greeting').
            and_respond(:status => 200, :body => json('message' => /howdy/))
          end
        end

        let(:response) do
          stubber = shokkenki.provider(:my_provider).stubber
          url = "http://#{stubber.host}:#{stubber.port}/greeting"
          HTTParty.get url
        end

        it 'is greeted with howdy' do
          expect(JSON.parse(response.body)['message']).to match(/howdy/)
        end

      end
      """
    Given a file named "spec/provider_spec.rb" with:
      """ruby
      require 'shokkenki/provider/rspec'

      class Greeter
        attr_writer :mood
        def call env
          raise "I don't recognise the request" unless recognised?(env)
          [200, {}, [%Q{{"message": "#{greeting}"}}]]
        end

        def greeting
          {
            'happy' => 'howdy',
            'angry' => 'get lost',
          }[@mood]
        end

        def recognised? env
          env['PATH_INFO'] == '/greeting' && env['REQUEST_METHOD'] == 'GET'
        end
      end

      greeter = Greeter.new

      Shokkenki.provider.configure do
        provider :my_provider do
          run greeter

          given /greeter is (.*)/ do |args|
            greeter.mood = args[:match][1]
          end
        end
      end

      Shokkenki.provider.redeem_tickets
      """
    When I run `rspec --format documentation spec/consumer_spec.rb && rspec --format documentation spec/provider_spec.rb`
    Then all specs should pass
    And the output should contain:
      """
      My Consumer
        is greeted with howdy
      """
    And the output should contain:
      """
      My Consumer
        greeting
          status
            is 200
          body
            json value
              message
                matches /(?-mix:howdy)/
      """