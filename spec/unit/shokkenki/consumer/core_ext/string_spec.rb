require_relative '../../../spec_helper'
require 'shokkenki/consumer/core_ext/string'

describe String do

  context 'as a shokkenki term' do

    subject { 'some string'.to_shokkenki_term }

    it 'is a string term' do
      expect(subject.type).to eq(:string)
    end
  end
end