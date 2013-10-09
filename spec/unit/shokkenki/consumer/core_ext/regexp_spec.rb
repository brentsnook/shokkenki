require_relative '../../../spec_helper'
require 'shokkenki/consumer/core_ext/regexp'

describe Regexp do

  context 'as a shokkenki term' do

    subject { /a[^b]/.to_shokkenki_term }

    it 'is a regexp term' do
      expect(subject.type).to eq(:regexp)
    end
  end
end