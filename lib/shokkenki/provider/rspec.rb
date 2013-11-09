require_relative 'provider'

require_relative 'model/ticket'
require_relative 'model/interaction'
require 'shokkenki/term/and_expression_term'
require 'shokkenki/term/string_term'
require 'shokkenki/term/number_term'
require 'shokkenki/term/regexp_term'

require_relative 'rspec/ticket'
require_relative 'rspec/interaction'
require_relative 'rspec/and_expression_term'
require_relative 'rspec/string_term'
require_relative 'rspec/number_term'
require_relative 'rspec/regexp_term'

Shokkenki::Provider::Model::Ticket.send :include, Shokkenki::Provider::RSpec::Ticket
Shokkenki::Provider::Model::Interaction.send :include, Shokkenki::Provider::RSpec::Interaction

Shokkenki::Term::AndExpressionTerm.send :include, Shokkenki::Provider::RSpec::AndExpressionTerm
Shokkenki::Term::StringTerm.send :include, Shokkenki::Provider::RSpec::StringTerm
Shokkenki::Term::NumberTerm.send :include, Shokkenki::Provider::RSpec::NumberTerm
Shokkenki::Term::RegexpTerm.send :include, Shokkenki::Provider::RSpec::RegexpTerm