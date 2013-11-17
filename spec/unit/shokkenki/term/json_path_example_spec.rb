require_relative '../../spec_helper'
require 'shokkenki/term/json_path_example'

describe Shokkenki::Term::JsonPathExample do
  context 'generated from a path and term' do

    let(:term) { double 'term', :example => 'term example' }
    let(:example) { Shokkenki::Term::JsonPathExample.new(path, term).to_example }

    context 'with a term containing only normal elements' do
      let(:path) { '$.first.second'}

      it 'contains the term example at the given path'
    end

    context 'when the path contains a recursive descent (..)' do
      it 'generates the example under the parent'
    end

    context "when the path contains a non-standard path element (not like ['element'])" do
      it 'fails'
    end
  end
end