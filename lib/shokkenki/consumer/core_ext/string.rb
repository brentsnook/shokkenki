require_relative '../term/string_term'

class String

  def to_shokkenki_term
    Shokkenki::Consumer::Term::StringTerm.new self
  end

end