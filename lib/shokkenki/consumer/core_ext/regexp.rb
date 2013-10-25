require_relative '../term/regexp_term'

class Regexp

  def to_shokkenki_term
    Shokkenki::Consumer::Term::RegexpTerm.new self
  end

end