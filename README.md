# Shokkenki

Shokkenki (食券機) records [consumer-driven contracts](http://martinfowler.com/articles/consumerDrivenContracts.html) from real examples and uses them to test both ends of a RESTful consumer-provider relationship.

Consumer tests can express a contract as a series of HTTP interactions that can be used to stub out the provider in those tests. Those interactions can then be saved as a shokkenki ticket and then used within provider tests to ensure that a provider honours that contract.

Shokkenki is based on [pact](https://github.com/uglyog/pact) and would not exist without the hard work of all of the contributors of that project.

![Under construction](/Under_contruction_icon-red.svg.png "Under construction")

## Still under construction!

This gem is still being built and will not work in the meantime.

Remaining before first usable release (0.1.0):

- manual testing

## Install

    gem install shokkenki

## Consumer Rspec

Shokkenki Consumer allows you to specify interactions with the provider from the consumer's point of view. These interactions are then used to stub the provider.

```ruby
require 'shokkenki/consumer/rspec'
require_relative 'hungry_man'

Shokkenki.consumer.configure do |c|
  c.define_provider :restaurant
end

describe HungryMan, :shokkenki_consumer => :hungry_man do

  context 'when his ramen is hot' do

    before do
      order(:my_provider).during('order for ramen').to do
        get('/order/ramen').
        and_respond(:body => /tasty/))
      end
    end

    it 'is happy' do
      expect(subject.happy?).to be_true
    end
  end
end
```

## Provider Rspec

Shokkenki Provider allows you to redeem (verify) a Shokkenki ticket against an actual provider.

```ruby
require 'shokkenki/provider/rspec'

class Restaurant
  def call env
    env['PATH_INFO'] == '/order/ramen' ? [200, {}, ['a tasty morsel']] : raise('Unsupported path')
  end
end

Shokkenki.provider.configure do
  provider(:restaurant) { run Restaurant.new }
end

Shokkenki.provider.redeem_tickets
```

When run, this example will define and run an RSpec specification:

```
Hungry Man
  order for ramen
    status
      is 200
    body
      matches /tasty/
```

## On the way ...

  - [Relish documentation](https://www.relishapp.com/shokkenki)
  - XML term - XPath matching within XML documents
  - Support for non-Rack providers
  - Register custom terms in both consumer and provider
  - Custom Faraday configuration - more control over how your provider is requested

## License

See [LICENSE.txt](LICENSE.txt).

This gem embeds and makes use of [ruby string random](https://github.com/repeatedly/ruby-string-random).


