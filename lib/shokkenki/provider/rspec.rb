require_relative 'provider'

require_relative 'model/ticket'
require_relative 'model/interaction'
require 'shokkenki/term/and_expression_term'
require 'shokkenki/term/string_term'
require 'shokkenki/term/number_term'
require 'shokkenki/term/regexp_term'
require 'shokkenki/term/json_paths_term'

require_relative 'rspec/ticket'
require_relative 'rspec/interaction'
require_relative 'rspec/term/and_expression_term'
require_relative 'rspec/term/string_term'
require_relative 'rspec/term/number_term'
require_relative 'rspec/term/regexp_term'
require_relative 'rspec/term/json_paths_term'

Shokkenki::Provider::Model::Ticket.send :include, Shokkenki::Provider::RSpec::Ticket
Shokkenki::Provider::Model::Interaction.send :include, Shokkenki::Provider::RSpec::Interaction

Shokkenki::Term::AndExpressionTerm.send :include, Shokkenki::Provider::RSpec::Term::AndExpressionTerm
Shokkenki::Term::StringTerm.send :include, Shokkenki::Provider::RSpec::Term::StringTerm
Shokkenki::Term::NumberTerm.send :include, Shokkenki::Provider::RSpec::Term::NumberTerm
Shokkenki::Term::RegexpTerm.send :include, Shokkenki::Provider::RSpec::Term::RegexpTerm
Shokkenki::Term::JsonPathsTerm.send :include, Shokkenki::Provider::RSpec::Term::JsonPathsTerm