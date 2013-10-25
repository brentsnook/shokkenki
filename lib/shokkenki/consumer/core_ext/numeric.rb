require 'shokkenki/consumer/term/number_term'

class Numeric

  def to_shokkenki_term
    Shokkenki::Consumer::Term::NumberTerm.new self
  end

end