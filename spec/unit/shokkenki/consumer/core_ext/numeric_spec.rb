require_relative '../../../spec_helper'
require 'shokkenki/consumer/core_ext/numeric'

describe Numeric do

  context 'as a shokkenki term' do

    subject { 9.to_shokkenki_term }

    it 'is a number term' do
      expect(subject.type).to eq(:number)
    end
  end
end