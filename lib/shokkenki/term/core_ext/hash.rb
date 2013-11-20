require_relative '../and_expression_term'

class Hash

  def to_shokkenki_term
    Shokkenki::Term::AndExpressionTerm.new self
  end

end