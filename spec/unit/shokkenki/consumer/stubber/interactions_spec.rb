require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/interactions'

describe Shokkenki::Consumer::Stubber::Interactions do
  context 'finding an interaction for a request' do

    let(:request) { double 'request' }

    context 'when a interaction was found' do

      let(:matching_interaction) { double 'matching interaction' }

      before do
        subject.add double('non matching interaction', :match_request? => false)
        subject.add matching_interaction
        subject.add double('non matching interaction 2', :match_request? => false)

        allow(matching_interaction).to receive(:match_request?).with(request).and_return(true)
      end

      it 'finds the matching interaction' do
        expect(subject.find(request)).to eq(matching_interaction)
      end
    end

    context 'when no response was found' do

      before do
        subject.add double('non matching interaction', :match_request? => false)
       end

      it 'finds nothing' do
        expect(subject.find(request)).to be_nil
      end

    end
  end

  context 'deleting all interactions' do

    before do
      subject.add double('interaction')
      subject.add double('interaction 2')

      subject.delete_all
    end

    it 'removes all interactions' do
      expect(subject.interactions).to be_empty
    end
  end

  context 'adding a new interaction' do

    let(:interaction) { double 'interaction' }

    before do
      subject.add interaction
    end

    it 'removes all interactions' do
      expect(subject.interactions).to include(interaction)
    end
  end
end