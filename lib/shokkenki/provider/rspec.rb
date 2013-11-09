require_relative 'provider'
require_relative 'model/ticket'
require_relative 'rspec/ticket'

Shokkenki::Provider::Model::Ticket.send :include, Shokkenki::Provider::RSpec::Ticket