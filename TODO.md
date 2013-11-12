
# Now

## Fixtures

- add producer support to recognise givens
  - fail if state is not recognised
  - otherwise set state up before running specs

  Shokkenki.provider.fixtures do

    given /a (sausage) exists/ do |thing, match(optional)|
       ...
    end

  end
  - stores fixtures as lambdas, runs them as before blocks at order level

## JSON term
    order(:my_provider).during('order for ramen').to do
        receive(:method => :get, :path => '/order/ramen').
        and_respond(:body => json('$.temperature' => /hot/)))

    order for ramen
      response
        body
          json
            $.temperature
              matches /hot/
- always assume multiple results from query
- how can you use path to create values? might need to only support subset for starters
  - raise exception in generate if path can't be generated
-  use JSONPath syntax and maybe https://github.com/joshbuddy/jsonpath

## Validate terms used in request!!!
  - method string_term and must be present
  - path string_term and must be present

## Tidy Up

- better name for and expression term?
- remove attributes in initializers?
- differentiate between providers when there is a failure in server - create server with provider name and use in identity?
- add working examples
- README
  - add a call to action on README - "problems? Feature request? Doesn't work the way you want? Create an issue!"
  - add a note about compatible ruby versions
  - Upate examples

## Testing

- RSpec 3 beta
- Ruby 1.9
- Ruby 2
- Works with Rails 3
- Works with Rails 4
- Fix RSpec versions required in gemspec
- Multiple consumer specs write to the same ticket successfully
- Can use Rails app as provider with no problems
- Can use blueprints to create data in AR with no problems
- Consumer can interact with multiple stubbed providers at once
- Works with RSpec 2
- Works with RSpec 3 beta
- Can drive a Javascript consumer app and have correct data show up
- Headers are supported across consumer and provider
- Multiple nested scenarios
- What happends when you specify different consumers in nested contexts?
- tickets via URI

## Release !!!!!!!!!!!!!!!!!!!

- check gemspec
- version 0.1.0 (major is 0 until split into gems then release all as 1.0.0)

## Split
  - shokkenki-provider
  - shokkenki-consumer
  - shokkenki-support
  - shokkenki - contains version
  - Don't forget to remove unused gem dependencies

## Relish documentation

- Shokkenki (shokkenki)
  - About
    - what does shokkenki do
     - Exampled-driven consumer-driven contracts
     - Targetted at HTTP interactions
     - Designed for RSpec and Rack Provider but extensible
    - why?
      - Integration testing sucks
      - Bringing down the cost of integration
        - Curve, number of services vs integration cost
    - what is a shokkenki?
      - food ticket machine
        - http://www.youtube.com/watch?v=-tZXGdWQZ5g
      - as a consumer you insert coins, press a button to select your meal
      - a paper ticket is dispensed which you hand to your food provider behind the counter
      - they prepare the food and call you over when it is finished
    - consumer driven contracts
      - http://martinfowler.com/articles/consumerDrivenContracts.html
    - consumer
      - the user of a service
      - may be another HTTP service, a Javascript application
      - a consumer requires a subset of the services offered by a provider
      - A consumer should specify the minimum that it cares about to avoid specs breaking uncessarily
    - provider
      - provides a range of services
      - has one or more consumers, each interested in a subset of overall services
      - the provider may change its behaviour and break different consumers in different ways
      - a provider may run executable consumer-driven contracts to ensure that it has not broken any consumers
    - request
      - path (required)
      - method (required)
      - query
      - body
      - headers
    - response
      - status
      - body
      - headers

  - Changelog
  - Cookbook
    - Writing Good Consumer Specs
      - Specify the absolute minimum
    - Options requests
    - Redeeming Tickets with a Provider Outside of Your Control
      - Twitter example
      - Defining host and port
    - Provider Databases
      - Ensuring data is set up/torn down - what to require?
    - Easy Data Setup with Blueprints
      - Using Factory Girl
        - fixture name corresponds to blueprint name
        - arguments are passed through as-is
    - Driving Javascript Consumers with Capybara
  - Contributing
    - Code
    - Documentation

- Shokkenki Consumer RSpec
  - Configuration
    - Ticket Location
      - Proc
      - file
      - url
    - Defining Providers
      - Specifying a Stubber
    - Defining Stubbers

  - Writing a Consumer Spec
    - Example Metadata
    - Orders
      - During (Labelling Interactions)
      - Given (Specifying Fixtures)
      - Receive (Specifying Requests)
      - And Respond (Specifying Responses)
    - Stubbers
      - HTTP Stubber
        - Interacting with the Stub Server
          - Host, Port
    - Terms - for the consumer
      - And Expression
        - Nested And Expressions
      - Or Expression
      - Regexp
        - regex terms uses ruby standard for regex
        - generate terms with ruby string random
      - String
      - Number
      - JSON
      - Registering Custom Terms
        - Configuration
        - Ensure they are supported in both consumer and provider
    - Tickets
      - JSON files that contain information about provider, consumer and interactions

  - Running Consumer Specs
    - Filtering
      - -- tag shokkenki_consumer:name
      - Link to RSpec relish doco on filters and command line filters
    - Troubleshooting
      - Unused Interactions
      - Unmatched Requests
      - Interacting With the Stubber
        - Finding all interactions
        - Finding unused interactions
        - Finding unmatched requests
        - But I want to know something else...
          - Please raise an issue and let us know what you need
        - Using Pry

- Shokkenki Provider RSpec
  - Configuration
    - Ticket Location
      - Proc
      - file
      - url
    - Defining Fixtures
    - Registering Providers
      - Application
        - Specifying a Rack Application
    - HTTP Requests
      - Configuring Faraday

  - Redeeming Tickets
    - Generating RSpec Examples
      - Structure

  - Running Provider Specs
    - Filtering
      - --tag shokkenki_provider
      - --example (interaction|request|headers)
      - Link to RSpec relish doco on filters and command line filters

# Next ...

## Add support for writing tickets ...
  - to URI (POST), application/json
  - to block (call)
  - to directory (already)
  - to file (if not a directory)

## XML term
- XPath expression

## Provide custom Faraday configuration
- allow a block to be set, eval this against faraday config last

## Misc
- Find a better way to stub new methods?
- document what can be included in a request
- convert other http examples like http_stubber to use webmock
- better end to end coverage around tickets?

## Either term - useful?
 order(:my_provider).during('order for ramen').to do
        receive(:method => either(:get, :post, :options))

## Not term - useful? - wraps term to negate its match, make terms negation-aware
## Any term - useful? - example by using first
## Array term - matches if values are an array with exact values

## Support for non-Rack providers
- Allow any server to be configured
  Shokkenki.provider(:restaurant){ already_running(:port => 3000) }.honours_tickets!
- Require a port but default to localhost for host
- Add hooks to allow server to be started/stopped as part of test run
  - Shokkenki.provider(:restaurant) do
    start { }
    stop { }
  end

## Later

- include version in consumer
  My Consumer (2.4.3)
    greeting
      status
        is 200
- allow custom terms to be configured
- add unique IDs to interactions - hashed from their contents - make it easier to spot unique interactions
- key interactions by unique ID and warn when they are being overwritten
- to/from_hash/json inconsistency
- Use Machinist to simplify specs
- Cucumber support
- Minitest support
- Steak support
- add default response params for those that are not given
  - consumer - response (default status is 200)
  - provider - request (default method is get)
- streaming content support - add to a wiki page of things it doesnt support
- HTTP session support
- Cookie support