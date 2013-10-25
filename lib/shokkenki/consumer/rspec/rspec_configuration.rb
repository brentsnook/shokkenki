require_relative '../../shokkenki'
require_relative '../rspec/example_group_binding'
require 'rspec'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.include Shokkenki::Consumer::RSpec::ExampleGroupBinding

  config.before(:each, :shokkenki_consumer => lambda{ |x| true }) do
    Shokkenki.consumer.current_consumer = example.metadata[:shokkenki_consumer]
    Shokkenki.consumer.clear_interaction_stubs
  end

  config.before(:suite) { Shokkenki.consumer.start }
  config.after(:suite) do
    Shokkenki.consumer.print_tickets
    Shokkenki.consumer.close
  end
end