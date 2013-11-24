require_relative '../hash_term'

class Hash

  def to_shokkenki_term
    Shokkenki::Term::HashTerm.new self
  end

end