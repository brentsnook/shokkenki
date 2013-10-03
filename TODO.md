## Consumer
- rename provider role to patronage
- normalise consumer and provider names
- rename set_current_consumer to current_consumer=
- [ ] watch out for require_relative and target version
- [ ] pull more out into separate DSL definition?

- introduce Patronage to link provider and consumer, update time as it has interactions

- [ ] add interactions
- [ ] add support for givens (existing provider state)
- [ ] check runtime ruby versions
- [ ] make sure examples work

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