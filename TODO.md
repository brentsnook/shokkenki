# Relish documentation for shokkenki-provider
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
        - Loaded from config.ru if none specified
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

# Remove traces of old crap like jsonpathexamplespec from consumer - search for this in both

# (provider) trim the failure stack trace the same way that rspec does
RSpec.configure do |config|
  config.backtrace_inclusion_patterns = [/shokkenki/]
end

# (all) Use more stable active support methods (ie. no deep_symbolize keys - use JSON parse options instead?) (across all gems)

# (all) Add Changelog for all 3 gems
  - How to add to releases?

# Now

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
- Works with RSpec 2
- Works with RSpec 3 beta
- Can drive a Javascript consumer app and have correct data show up
- Headers are supported across consumer and provider
- Multiple nested scenarios
- What happends when you specify different consumers in nested contexts?
- tickets via URI

## When requests not matched...

Perhaps you need to define an interaction for it or there is a problem with the interactions already defined?
Perhaps it was defined incorrectly or the consumer never made a request that matches it?

## README
  - add a call to action on README - "Problems? Want a feature? Doesn't work the way you want? Create an issue!"
  - add a note about compatible ruby versions
  - Update examples

## Release !!!!!!!!!!!!!!!!!!!

- check gemspec
- version 1.0.0

# Next ...

## Expose all interactions and all requests from stubber

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