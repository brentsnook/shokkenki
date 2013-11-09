require_relative 'provider'
require_relative 'model/ticket'
require_relative 'model/interaction'
require_relative 'rspec/ticket'
require_relative 'rspec/interaction'

Shokkenki::Provider::Model::Ticket.send :include, Shokkenki::Provider::RSpec::Ticket
Shokkenki::Provider::Model::Interaction.send :include, Shokkenki::Provider::RSpec::Interaction