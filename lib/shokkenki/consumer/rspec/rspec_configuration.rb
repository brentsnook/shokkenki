require_relative 'example_group_binding'
require_relative 'hooks'
require 'rspec'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.include(
    Shokkenki::Consumer::RSpec::ExampleGroupBinding,
    :shokkenki_consumer => lambda{ |x| true }
  )

  config.before(:suite) { Shokkenki::Consumer::RSpec::Hooks.before_suite }

  config.before(:each, :shokkenki_consumer => lambda{ |x| true }) do
    Shokkenki::Consumer::RSpec::Hooks.before_each example.metadata[:shokkenki_consumer]
  end

  config.after(:suite) { Shokkenki::Consumer::RSpec::Hooks.after_suite }
end