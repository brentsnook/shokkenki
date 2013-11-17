
require 'shokkenki/term/term'

describe Shokkenki::Term::Term do

  context 'as a shokkenki term' do
    it 'is its self' do
      expect(subject.to_shokkenki_term).to be(subject)
    end
  end
end