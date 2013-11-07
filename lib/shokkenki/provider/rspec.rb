require_relative 'provider'
require_relative 'rspec/rspec_ticket_verifier'

Shokkenki.provider.ticket_verifier = Shokkenki::Provider::RSpec::RSpecTicketVerifier.new