require_relative '../term/and_expression_term'

class Hash

  def to_shokkenki_term
    values = self.inject({}) do |mapped, keyvalue|
      key, value = *keyvalue
      mapped[key] = value.to_shokkenki_term
      mapped
    end
    Shokkenki::Consumer::Term::AndExpressionTerm.new values
  end

end