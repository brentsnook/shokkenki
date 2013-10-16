## Provider Stub - Remote Server - shokkenki/provider-stub/remote
- start remote server on session start (stubber reads port from started remote) [ ][ ]
- stop remote server on session stop - [ ][ ]

- fake it til you make it - server returns canned responses - [ ]
- stub server accepts interactions [ ][ ]
- stub server responds according to received request [ ][ ]
- stub server generates body using rubystringrandom [ ][ ]
- add note to readme about rubystringrandom [ ]
- separate parsing, interpretation and matching of interactions from actual stubbing - allow this logic to be used from stub server or from webmock

1 reconstitute interaction
2 turn incoming request into a shokkenki request
  - method
  - body
  - content_type etc.
3 Find matching interaction by applying matchers
  - search through list for starters, index later if too slow
4 Generate response using term
  - term.generate_example
    - uses RubyStringRandom for Regexp
    - Strings are returned as is for StringTerm

- make http stubber default + remove null stubber
- use http stubber in integration specs
- make http stubber usable apart from server
- convert other http examples like http_stubber to use webmock

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

- check runtime ruby versions [ ]
- update examples and ensure that they work [ ]
- make provider stubbing method configurable
  - including consumer/provider-stub/server mixes it into the configuration
- make DSL closer to RSpec: shokkenki.order(:my_provider).to { receive('a greeting').with({}).and_respond({}) }
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

- HTTPS support