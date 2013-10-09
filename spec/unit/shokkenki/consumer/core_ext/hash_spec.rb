require_relative '../../../spec_helper'
require 'shokkenki/consumer/core_ext/hash'

describe Hash do

  context 'as a shokkenki term' do

    subject { {:a => 'apples' }.to_shokkenki_term }

    it 'is an and expression term (all values must match)' do
      expect(subject.type).to eq(:and_expression)
    end
  end
end