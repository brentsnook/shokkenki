require_relative '../../../spec_helper'
require 'shokkenki/term/json_paths_term'
require 'shokkenki/consumer/dsl/term_dsl'

describe Shokkenki::Consumer::DSL::TermDSL do

  class TermDSLStub
    include Shokkenki::Consumer::DSL::TermDSL
  end

  subject { TermDSLStub.new }

  context 'json' do
    let(:paths) { {'path' => 'other term'} }
    let(:term) { double 'term' }

    before do
      allow(Shokkenki::Term::JsonPathsTerm).to receive(:new).with(paths).and_return(term)
    end

    it 'creates a new JSON term' do
      expect(subject.json(paths)).to be(term)
    end
  end
end