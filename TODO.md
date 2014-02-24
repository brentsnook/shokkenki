# Add consumer/provider doco cross references (30m)
  - ticket
  - fixtures

# (all) Add Changelog for all 3 gems (30m)
  - How to add to releases?

## Testing (3hr)

== Simple scenarios

- create test project
- Multiple consumer specs write to the same ticket successfully
- Can drive a Javascript consumer app and have correct data show up
- Headers are supported across consumer and provider
- Multiple nested scenarios
- What happends when you specify different consumers in nested contexts?
- tickets via URI

== Ruby versions (30m)

- consult travis page, timebox if taking too long
- Ruby 1.9.2
- Ruby 1.9.3
- Ruby 2.0.0
- Ruby 2.1.0
- rubinius
- jruby

== Rails

- Works with Rails 3 provider
- Works with Rails 4 provider

== RSpec

- Earliest version of 2
- Latest version of 2
- 3 beta

== Fixtures

- Factory girl + AR for fixtures
- Machinist + AR for fixtures

## README
  - add a note about compatible ruby versions (1.9 up)

## Release !!!!!!!!!!!!!!!!!!!

- check gemspec
- version 1.0.0
- order
  - support
  - consumer
  - provider
  - shokkenki
- relish
  - create version 1.0.0 for all
  - publish doco for all and publisher
- ensure build works for all

# Next ...

## Add all new features as tickets, allow people to vote
  - XML term - XPath matching within XML documents
  - Support for non-Rack providers
  - Register custom terms in both consumer and provider
  - Custom Faraday configuration - more control over how your provider is requested
  - Add line numbers to rspec failure traces for provider specs


## When requests not matched...

Perhaps you need to define an interaction for it or there is a problem with the interactions already defined?
Perhaps it was defined incorrectly or the consumer never made a request that matches it?


## Expose all interactions and all requests from stubber

## Provider uses config.ru if no app given

## Non-rack apps supported in provider

## Add consumer driven contracts 101 page
  - driven from consumer - provider is subservient (the customer is always right)
  - consumer interested in a subset (menu) of what provider provides
  - provider is responsible for not breaking consumers

## Further Relish documentation

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

- set up coveralls

- Fix up code climate smells

- use config.ru if no app supplied

- Can the two models be merged? Should they?

- remove attributes in initializers?
- move stubber middleware classes into own high-level package
- Add meaningful failures when actual value/s have not been populated

- support numeric path elements etc. when generating json term example

- Automatically assign interaction label
  - GET /path

## Add support for writing tickets ...
  - to URI (POST), application/json
  - to block (call)
  - to directory (already)
  - to file (if not a directory)

## Allow ticket read from URI to be a single ticket instead of an array

## XML term
- XPath expression

## Provide custom Faraday configuration
- allow a block to be set, eval this against faraday config last


## Misc
- Find a better way to stub new methods?
- document what can be included in a request
- convert other http examples like http_stubber to use webmock
- better end to end coverage around tickets?
- differentiate between providers when there is a failure in server - provider should wrap and handle exceptions rather than just delegate

## Either term - useful?
- order(:my_provider).during('order for ramen').to do
        receive(:method => either(:get, :post, :options))

## Not term - useful? - wraps term to negate its match, make terms negation-aware
## Any term - useful? - example by using first, could be used with json paths term
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

## Allow stub server to be run via the command line
  - Allows features to be driven from the from the front end
  - Allow it to be easily racked up with pow (command to create a pow directory?)
  - Can pass same args as tickets to read ticket from file, directory or URL
  - Allow a series of interactions to be scripted with
    - Shokkenki.consumer.bulk do
        order(:my_provider).to {}
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