require_relative '../../spec_helper'
require 'shokkenki/term/json_path_example'

describe Shokkenki::Term::JsonPathExample do
  context 'generated from a path and term' do

    let(:term) { double 'term', :example => 'term example' }
    let(:example) { Shokkenki::Term::JsonPathExample.new(path, term).to_example }

    context 'with a path starting at the root ($)' do
      let(:path) { '$.first.second'}

      it 'contains the term example at the given path, starting at the root' do
        expect(example).to eq({'first' => {'second' => 'term example'}})
      end
    end

    context "with a path that doesn't start at the root" do
      let(:path) { 'first.second'}

      it 'contains the term example at the given path, starting at the root' do
        expect(example).to eq({'first' => {'second' => 'term example'}})
      end
    end

    context 'when the path contains a recursive descent (..)' do
      let(:path) { 'first.second..third'}

      it 'generates the example under the parent' do
        expect(example).to eq({'first' => {'second' => {'third' => 'term example'}}})
      end

    end

    context 'when the path contains a wildcard (*)' do
      let(:path) { 'first.*.third' }

      it "generates the example under an element named 'wildcard'" do
        expect(example).to eq({'first' => {'wildcard' => {'third' => 'term example'}}})
      end

    end

    context 'when the path contains a numeric element (second[5])' do
      let(:path) { 'first.second[2]' }

      it 'fails' do
        expect{ example }.to raise_error(/Numeric element '\[2\]' is not supported/)
      end

    end

    context 'when the path contains a filter element (second[?(@.thing)])' do
      let(:path) { 'first.second[?(@.thing)]' }

      it 'fails' do
        expect{ example }.to raise_error(/Filter element '\[\?\(@\.thing\)\]' is not supported/)
      end

    end

    context 'when the path contains a union element (second[0,1])' do
      let(:path) { 'first.second[0,1]' }

      it 'fails' do
        expect{ example }.to raise_error(/Union element '\[0,1\]' is not supported/)
      end

    end

    context 'when the path contains an array slice element (second[:2])' do
      let(:path) { 'first.second[:2]' }

      it 'fails' do
        expect{ example }.to raise_error(/Array slice element '\[:2\]' is not supported/)
      end

    end

    context 'when the path contains a script element (second[(@.length-1)])' do
      let(:path) { 'first.second[(@.length-1)]' }

      it 'fails' do
        expect{ example }.to raise_error(/Script element '\[\(@\.length-1\)\]' is not supported/)
      end

    end

    context 'when the path contains an unrecognised element (%)' do
      let(:path) { 'first.%' }

      it 'fails' do
        expect{ example }.to raise_error(/Unrecognised element '.*%' is not supported/)
      end

    end
  end
end