require_relative '../../../spec_helper'
require 'shokkenki/term/core_ext/hash'

describe Hash do

  context 'as a shokkenki term' do

    let(:shokkenki_term) { double 'shokkenki term' }
    let(:value) { double('value', :to_shokkenki_term => shokkenki_term) }
    subject { {:a => value }.to_shokkenki_term }

    it 'is a hash term' do
      expect(subject.type).to eq(:hash)
    end

    it 'forces each of the hash values into a shokkenki term' do
      expect(subject.values).to eq({:a => shokkenki_term })
    end
  end
end