## Server Producer Stubbing - ConsumerEnd

- add rspec config to remove interactions on all provider stubs before shokkenki consumer spec
- add rspec config to start Session
- Implement Session start
  - notifies all providers of session start - session_started
  - provider in turn notifies stub
- add rspec config to stop session
  - notifies all providers of session stop, they notify stub
- allow shokkenki config to configure provider:
  Shokkenki.consumer.configure do |c|
    c.provider(:my_provider).configure do |p|
      p.stub_using(:remote).on_port 1234
    end
  end
- introduce RemoteStubber - created with an address and port, stubs by
 POST -> /shokkenki/interactions
 DELETE -> /shokkenki/interactions
- register this stubber

## Provider Stub - Remote Server - shokkenki/provider-stub/remote

- HOW WILL THE SERVER TELL THE REMOTE STUBBER ABOUT THE PORT?

- Implement session_start - spawn server [ ][ ]
- Implement session_stop - close down server [ ][ ]

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