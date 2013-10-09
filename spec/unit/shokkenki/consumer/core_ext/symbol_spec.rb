require_relative '../../../spec_helper'
require 'shokkenki/consumer/core_ext/symbol'

describe Symbol do

  context 'as a shokkenki term' do

    subject { :some_symbol.to_shokkenki_term }

    it 'is a string term' do
      expect(subject.type).to eq(:string)
    end
  end
end