Example-driven consumer-driven contracts.

Shokkenki (食券機) records [consumer-driven contracts](http://martinfowler.com/articles/consumerDrivenContracts.html) from real examples and uses them to test both ends of a RESTful consumer-provider relationship.

[Shokkenki Consumer](https://github.com/brentsnook/shokkenki-consumer) provides support for stubbing providers and generating tickets.

[Shokkenki Provider](https://github.com/brentsnook/shokkenki-provider) provides support for verifying tickets against an actual provider.

This is the documentation site for all Shokkenki projects.

## What?

A shokkenki is a [Japanese food ticket vending machine](http://www.youtube.com/watch?v=-tZXGdWQZ5g).

A hungry consumer inserts their money, makes a selection and then out pops a ticket. They hand their ticket to the food provider behind the counter and the order is fulfilled.

This project is a tool for generating and using simple, powerful consumer-driven contracts.

## Who?

### Consumer

A Shokkenki consumer is a system that makes use of a service via a RESTful interface.

A consumer is interested in a subset of the services offered by a provider and should aim to specify only the minimum that it is interested in. Avoiding specifying things that a consumer doesn't really care about helps to keep a consumer contract targetted - it will only break when a relevant feature breaks.

Examples of a consumer include an [AngularJS](http://http://angularjs.org) application or even another service.

### Provider

A Shokkenki *provider* is a system that provides a service via a RESTful interface. It might offer functions like storing data or allowing it to be retrieved.

A provider cares about the consumers it services and the aim of consumer-driven contracts are to allow a provider to know when and how it has broken a particular consumer.

A provider may in turn be a consumer for a different service that it relies on in order to do its job.

## How?

Shokkenki is **similar** [VCR](https://github.com/vcr/vcr) in that it plays back interactions to a consumer of an HTTP service in order to stub out that service.

Shokkenki is **different** to [VCR](https://github.com/vcr/vcr) in that it allows interactions to be **specified explicitly** instead of just **recorded**. Those interactions can then be used to test the provider too. It goes a little something like this:

1. Consumer A spells out desired interactions with Provider B as a series of requests and responses
2. Those interactions are used to stub out Provider B during consumer A tests
3. A ticket is produced describing the expected interactions between consumer A and provider B
4. Provider B uses that ticket during its own tests to verify that it hasn't broken consumer A

## Why?

To keep consumers and providers in synch with concise, fast, automated specifications.

Automated integration testing in a traditional sense is painful. Tests that set up several dependant systems with the right data, run a scenario through them and then attempt to verify the results can quickly become unwieldly and complex.

[Consumer-driven contracts](http://martinfowler.com/articles/consumerDrivenContracts.html) are a great way to provide feedback about whether and how a provider has broken particular consumers but producing and maintaining them can be hard. If they are not driven from real examples then they can quickly drift away from how the consumer actually works.

Shokkenki aims to make generating and using consumer-driven contracts easy.