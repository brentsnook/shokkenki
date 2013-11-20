require_relative '../number_term'

class Numeric

  def to_shokkenki_term
    Shokkenki::Term::NumberTerm.new self
  end

end