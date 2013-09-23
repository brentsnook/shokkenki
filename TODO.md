## Consumer

- [ ] record interactions using DSL
- [ ] spec writes out ticket after a run
- [ ] allow ticket location to be configured
- [ ] add support for givens (existing provider state)

## Server Producer Stubbing

- [ ] look at Faraday - does it provide a mock server that can be used?
- [ ] stub server starts as part of all spec runs
- [ ] stub server starts as part of specs tagged with shokkenki (shokkenki-contract?)
- [ ] stub server shuts down as part of a run
- [ ] stub server accepts interactions
- [ ] stub server responds according to received request
- [ ] add note to readme about rubystringrandom
- [ ] support and doco for running the server on the command line

## Producer

- [ ] run with hard coded interactions, pass or fail
- [ ] read ticket from hardcoded location and test interactions
- [ ] read ticket from specified location
- [ ] nice syntax highlighting in results
- [ ] result diffing? nice way to show the interactions that matched?
- [ ] Rake task
- [ ] add support for implementing givens (existing provider state)

## Webmock Producer Stubbing

- [ ] Allow stubbing method to be specified (server, webmock)
- [ ] Convert recorded interactions into webmock stubs