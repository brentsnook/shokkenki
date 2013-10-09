require 'shokkenki/consumer/term/string_term'

class Symbol

  def to_shokkenki_term
    Shokkenki::Consumer::Term::StringTerm.new self
  end

end