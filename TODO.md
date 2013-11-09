
# Now

## Provider

- ensure that multiple nested and terms will not overwrite actual_values ???
- Interaction defines actual_values as provider response
- Use Faraday to make HTTP requests - default to NetHttp and using rack adapter (rack::test)
- Support body
- Support headers
- Allow Rack server to be configured

- read tickets from specified location (file path, URI or lambda) [ ]

- add producer support to recognise givens
  - fail if state is not recognised
  - otherwise set state up before running specs

  Shokkenki.provider.fixtures do

    given 'a thing exists' do |thing|
       ...
    end

  end
  - stores fixtures as lambdas, runs them as before blocks at order level

- RSpec support just registers a new TicketListener? that creates examples from ticket
- Add documentation on selective spec running with --example

## Tidy Up

- split into shokkenki-provider, shokkenki-consumer and shokkenki-core gems. Don't forget to remove unused gem dependencies. Move version into Shokkenki core
- better name for and expression term?
- check runtime ruby versions [ ]
- update examples and ensure that they work [ ]
- watch out for require_relative and target version
- differentiate between providers when there is a failure in server
- document
  - what is a shokkenki?
    - food ticket machine
    - as a consumer you insert coins, press a button to select your meal
    - a paper ticket is dispensed which you hand to your food provider behind the counter
    - they prepare the food and call you over when it is finished
  - consumer driven contracts
  - consumer
  - provider
  - ticket
  - terms
    - regex terms uses ruby standard for regex
      - generate terms with ruby string random
    - creating your own
      - as long as both the provider and consumer support them
  - fixtures
  - add a call to action on README - "problems? Feature request? Doesn't work the way you want? Create an issue!"
  - wtf is going on
    - use pry to interrogate the provider
      provider.stubber.interactions
      provider.stubber.unused_interactions
      provider.stubber.requests
        /interactions?hit_count='0'

- release !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Next ...

## JSON Matcher
    order(:my_provider).during('order for ramen').to do
        receive(:method => :get, :path => '/order/ramen').
        and_respond(:body => json('$.temperature' => /hot/)))

    order for ramen
      response
        body
          json
            $.temperature
              matches /hot/

-  use JSONPath syntax and maybe https://github.com/joshbuddy/jsonpath

## Either Matcher
 order(:my_provider).during('order for ramen').to do
        receive(:method => either(:get, :post, :options))

- support passing additional configuration to faraday in the provider config

- Allow any server to be configured
  Shokkenki.provider(:restaurant){ already_running(:port => 3000) }.honours_tickets!
- Require a port but default to localhost for host
- Add hooks to allow server to be started/stopped as part of test run
  - Shokkenki.provider(:restaurant) do
    start { }
    stop { }
  end

- Find a better way to stub new methods?
- document what can be included in a request
- convert other http examples like http_stubber to use webmock
- better end to end coverage around tickets?

- provide a verbose mode enabled with SHOKKENKI_OPTIONS='-verbose'
  - prints out all interactions
    All interactions:
      []
    All requests:
      []



## Remove argument passed in to configuration methods

## Support for non-Rack providers

- Just test running webapps at a particular address and port - [ ][ ][ ]

## README/Wiki notes

- where does the name come from? Japanese food ticket machine (emojis)
  - put this in wiki page or on Readme?
- which problems/situations drove a need for this? integration testing large numbers of components (like Microservices)
- what does it target? (rspec consumers, ruby or driving JS apps with Capybara and Rack providers)
- what will it hopefully target? (Javascript consumers via unit tests + stubbing, http mocking in Angular/Ember/Backbone - shokkenki-consumer-angular)
- how can it be used to test a provider that I don't control? Using it to test github API as an example
- Issues/contributing

## Tests

- Multiple nested scenarios
- What happends when you specify different consumers in nested contexts?


## Later

## shokkenki-angular.js

- Allow tickets to be produced from Jasmine run angular specs. [ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ]

- support and doco for running the server on the command line [ ][ ][ ]
- allow custom terms to be configured
- Rake task for provider tests
- add unique IDs to interactions - hashed from their contents - make it easier to spot unique interactions
- key interactions by unique ID and warn when they are being overwritten
- Use Machinist to simplify specs
- Cucumber support
- Minitest support
- Steak support
- add default response params for those that are not given
  - for example, default status to 200
- streaming content support - add to a wiki page of things it doesnt support
- HTTP session support