## Provider Stub - Remote Server - shokkenki/provider-stub/remote

- rename term to term_factory
- and term
  - better name for and-term?
- string term
- regex term
- regex term generates body using rubystringrandom [ ][ ]
- add note to readme about rubystringrandom [ ]
- separate parsing, interpretation and matching of interactions from actual stubbing - allow this logic to be used from stub server or from webmock

- deal with 500 responses in the http_stubber
- make startup failures in server easy to diagnose (eg. load path problem)
- make http stubber default + remove null stubber
- use http stubber in integration specs
- make http stubber usable apart from server
- add unique IDs to interactions - hashed from their contents - make it easier to spot unique interactions
- key interactions by unique ID and warn when they are being overwritten
- add a hit count to interactions - ensure this shows up on deletion log
- log created interactions to rack log - INFO
- log stubbed request to rack log - INFO
- log deleted requests - INFO
- log unrecognised interactions to rack log - WARN
- convert other http examples like http_stubber to use webmock
- rename and restructure modules for middleware
- add a call to action on README - "problems? Feature request? Doesn't work the way you want? Create an issue!"
- rename shokkenki to shokkenki-consumer
- Find a better way to stub new methods?
- document what can be included in a request

## Logging
  - Server response polling - debug
  - Actual server logging

## Provider

- run with hard coded interactions, pass or fail [ ]
- read ticket from hardcoded location and test interactions [ ][ ][ ][ ]
- read ticket from specified location [ ]
- nice syntax highlighting in results [ ][ ][ ]
- Rake task [ ]

## Tidy Up

- make DSL closer to RSpec: shokkenki.order(:my_provider).to { receive('a greeting').with({}).and_respond({}) }
- check runtime ruby versions [ ]
- update examples and ensure that they work [ ]
- make provider stubbing method configurable
  - including consumer/provider-stub/server mixes it into the configuration
- watch out for require_relative and target version
- better end to end coverage around tickets?
- document terms
  - regex terms uses ruby standard for regex
- release

## Given State Support

- add consumer support to generate givens in ticket:
  - given('there is an apple', :colour => 'red')
- add producer support to recognise givens
  - fail if state is not recognised
  - otherwise set state up before running specs

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

## Later


- add default response params for those that are not given
  - for example, default status to 200
- streaming content support - add to a wiki page of things it doesnt support
- HTTP session support