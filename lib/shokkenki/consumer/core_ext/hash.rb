require 'shokkenki/consumer/term/and_expression_term'

class Hash

  def to_shokkenki_term
    Shokkenki::Consumer::Term::AndExpressionTerm.new self
  end

end