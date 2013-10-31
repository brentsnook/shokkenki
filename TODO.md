## Provider Stub - Remote Server - shokkenki/provider-stub/remote

- Rename rack_server to stub_server_middleware
- Merge middleware and stub_server_middleware - makes error reporting clearer
- Introduce StubbedServerMiddlewareException
  - accepts an exception
  - uses the message from the given exception
  - uses Kernel.caller to add to the stack trace
  - strips out first line of caller (inside of the exception class)
- Throw StubbedServerMiddlewareException from assert_ok!

- After each example ->
  - Fail if unmatched requests were found:
    The following requests were not matched by any interaction:
      []
  - Fail if unused interactions were found:
    The following interactions did not match any request:
      []

- provide a verbose mode enabled with SHOKKENKI_OPTIONS='-verbose'
  - prints out all interactions
    All interactions:
      []
    All requests:
      []
- provide all interactions as an endpoint: GET shokkenki/interactions
- provide requests as an endpoint: GET shokkenki/requests
- add matched_requests to interaction
- add matching_interaction to request
- add response to request

- add unique IDs to interactions - hashed from their contents - make it easier to spot unique interactions
- key interactions by unique ID and warn when they are being overwritten

## Provider

Hungry Man (describe)
  order for ramen (describe)
    response (describe)
      status (describe)
        is 200 (it)
      header (describe)
        Content-Type
          is application/json (it - StringTerm: 'is #{value}')
      body
        matches /sdsd/ (RegexTerm: 'matches #{pattern}')




- run with hard coded interactions, pass or fail [ ]
- read ticket from hardcoded location and test interactions [ ][ ][ ][ ]
- read tickets from specified location (file path, URI or lambda) [ ]
- add producer support to recognise givens
  - fail if state is not recognised
  - otherwise set state up before running specs
- RSpec support just registers a new TicketListener? that creates examples from ticket
- nice syntax highlighting in results [ ][ ][ ]
- Rake task [ ]

## Tidy Up

- better name for and expression term?
- check runtime ruby versions [ ]
- update examples and ensure that they work [ ]
- make provider stubbing method configurable
  - including consumer/provider-stub/server mixes it into the configuration
- watch out for require_relative and target version
- convert other http examples like http_stubber to use webmock
- better end to end coverage around tickets?
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
  - wtf is going on
    - use pry to interrogate the provider
      provider.stubber.interactions
      provider.stubber.unused_interactions
      provider.stubber.requests
        /interactions?hit_count='0'

- release !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

- add a call to action on README - "problems? Feature request? Doesn't work the way you want? Create an issue!"
- rename shokkenki to shokkenki-consumer
- Find a better way to stub new methods?
- document what can be included in a request
- split term model into separate gem

## Support for non-Rack providers

- Just test running webapps at a particular address and port - [ ][ ][ ]

## Webmock Producer Stubbing

- Use to_rack to hook up to existing rack server [ ][ ][ ][ ]
  - https://github.com/bblimke/webmock#rack-responses

## shokkenki-angular.js

- Allow tickets to be produced from Jasmine run angular specs. [ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ]

- support and doco for running the server on the command line [ ][ ][ ]

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

- Cucumber support
- Minitest support
- Steak support
- add default response params for those that are not given
  - for example, default status to 200
- streaming content support - add to a wiki page of things it doesnt support
- HTTP session support