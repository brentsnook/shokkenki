# Shokkenki

Shokkenki (食券機) records [consumer-driven contracts](http://martinfowler.com/articles/consumerDrivenContracts.html) from real examples and uses them to test both ends of the consumer-provider relationship.

Consumer tests can express a contract as a series of HTTP interactions that can be used to stub out the provider in those tests. Those interactions can then be saved as a shokkenki ticket and then used within provider tests to ensure that a provider honours that contract.

Shokkenki is based on [pact](https://github.com/uglyog/pact) and would not exist without the hard work of all of the contributors of that project.

![Under construction](/Under_contruction_icon-red.svg.png "Under construction")

## Still under construction!

This gem is still being built and will not work in the meantime.

Remaining before a usable release:

- allow provider to be stubbed as a running server
- add provider test support

## Install

    gem install shokkenki

## Examples

### Consumer Rspec spec

```ruby
require 'shokkenki/consumer/rspec'
require_relative 'hungry_man'

describe HungryMan, :shokkenki => {:consumer => :hungry_man} do

  shokkenki.provider :restaurant do
    stubbed_as_server do
      on_port 1234
    end
  end

  context 'when his ramen is hot' do

    before do
      shokkenki.order(:my_provider).during('an order for ramen').to do
        receive(:method => :get, :path => '/order/ramen').
        and_respond(:body => { :temperature => /hot/ })
      end
    end

    it 'is happy' do
      expect(subject.happy?).to be_true
    end
  end
end
```

When run, [this consumer example](examples/consumer/hungry_man_spec.rb) produces a new ticket named **/examples/tickets/hungry_man-restaurant.json** in the examples directory.

### Provider Rspec spec

```ruby
require 'shokkenki/provider/rspec'
require 'shokkenki/provider/rack'
require 'restaurant'

shokkenki.provider(:restaurant) {
  racked_up_as { Restaurant }
}.honours_tickets!

```

When run, [this provider example](examples/provider/restaurant_spec.rb) will define a series of rspec examples for each interaction in any found tickets. It will find the ticket created by the previous consumer example by default.

## License

See [LICENSE.txt](LICENSE.txt).

This gem embeds and makes use of [ruby string random](https://github.com/repeatedly/ruby-string-random).


