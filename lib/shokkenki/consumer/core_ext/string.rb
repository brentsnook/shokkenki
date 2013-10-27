require 'shokkenki/term/string_term'

class String

  def to_shokkenki_term
    Shokkenki::Term::StringTerm.new self
  end

end