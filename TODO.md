## Consumer
- Introduce Terms [ ][ ][ ]
  - StringTerm
  - RegexTerm
  - Open up Regex, Symbol and String and provide to_shokkenki_term method
- Make request and response free-form lists of headers + body [ ][ ]
- add support for givens (existing provider state) [ ][ ][ ][ ]

- error handling for missing requests/responses etc [ ][ ]
- check runtime ruby versions [ ]
- update examples and ensure that they work [ ]
- better name for 'shokkenki.order' ?
- watch out for require_relative and target version

## Server Producer Stubbing

- separate parsing, interpretation and matching of interactions from actual stubbing - allow this logic to be used from stub server or from webmock
- look at Faraday - does it provide a mock server that can be used? [ ]
- stub server starts as part of all spec runs [ ][ ]
- stub server shuts down as part of a run [ ]
- stub server accepts interactions [ ][ ]
- stub server responds according to received request [ ][ ]
- stub server generates body using rubystringrandom [ ][ ]
- add note to readme about rubystringrandom [ ]

## Producer

- run with hard coded interactions, pass or fail [ ]
- read ticket from hardcoded location and test interactions [ ][ ][ ][ ]
- read ticket from specified location [ ]
- nice syntax highlighting in results [ ][ ][ ]
- Rake task [ ]
- add support for implementing givens [ ][ ][ ]

## Webmock Producer Stubbing

- Allow stubbing method to be specified (server, webmock) [ ][ ][ ]
- Convert recorded interactions into webmock stubs [ ][ ]

## shokkenki-angular.js

- Allow tickets to be produced from Jasmine run angular specs. [ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ][ ]

- support and doco for running the server on the command line [ ][ ][ ]