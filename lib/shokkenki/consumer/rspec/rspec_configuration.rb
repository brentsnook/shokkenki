require_relative '../../shokkenki'
require_relative '../rspec/example_group_binding'
require_relative '../model/role'
require 'rspec'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.include(
    Shokkenki::Consumer::RSpec::ExampleGroupBinding,
    :shokkenki_consumer => lambda{ |x| true }
  )

  config.before(:each, :shokkenki_consumer => lambda{ |x| true }) do
    name = example.metadata[:shokkenki_consumer][:name]
    Shokkenki.consumer.add_consumer(Shokkenki::Consumer::Model::Role.new(example.metadata[:shokkenki_consumer])) unless Shokkenki.consumer.consumer(name)
    Shokkenki.consumer.set_current_consumer name
    Shokkenki.consumer.clear_interaction_stubs
  end

  config.before(:suite) { Shokkenki.consumer.start }
  config.after(:suite) do
    Shokkenki.consumer.print_tickets
    Shokkenki.consumer.close
  end
end