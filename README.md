# Shokkenki

Shokkenki (食券機) records [consumer-driven contracts](http://martinfowler.com/articles/consumerDrivenContracts.html) from real examples and uses them to test both ends of a RESTful consumer-provider relationship.

Check out the [Relish documentation](https://relishapp.com/shokkenki) for details on what it does, how it works and how to use it.

[Shokkenki Consumer](https://github.com/brentsnook/shokkenki-consumer) provides support for stubbing providers and generating tickets.

[Shokkenki Provider](https://github.com/brentsnook/shokkenki-provider) provides support for verifying tickets against an actual provider.

This is a meta-gem that ties together compatible versions of Shokkenki Consumer and Shokkenki Provider.

Shokkenki is based on [pact](https://github.com/uglyog/pact) and would not exist without the hard work of all of the contributors of that project.

![Under construction](/Under_contruction_icon-red.svg.png "Under construction")

## Still under construction!

Remaining before first usable release (1.0.0):

- manual testing

## Install

    gem install shokkenki

## On the way ...

  - [Relish documentation](https://www.relishapp.com/shokkenki)
  - XML term - XPath matching within XML documents
  - Support for non-Rack providers
  - Register custom terms in both consumer and provider
  - Custom Faraday configuration - more control over how your provider is requested

## Need help?

Try the [Shokkenki Google Group](http://groups.google.com/forum/#!forum/shokkenki) (you must be a member to post).

## Bugs or Feature Requests for the Project/Documentation?

Please use the appropriate Github issues:

- [Shokkeni](http://github.com/brentsnook/shokkenki/issues) - general Shokkenki
- [Shokkenki Consumer](http://github.com/brentsnook/shokkenki-consumer/issues)
- [Shokkenki Provider](http://github.com/brentsnook/shokkenki-provider/issues)

Have your say on the features that you want.

## License

See [LICENSE.txt](LICENSE.txt).


