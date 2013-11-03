require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/interactions'

describe Shokkenki::Consumer::Stubber::Interactions do

  let(:request) { double('request').as_null_object }

  context 'finding an interaction for a request' do

    context 'when an interaction was found' do

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

      it 'adds the matched interaction to the request' do
        subject.find request
        expect(request).to have_received(:interaction=).with(matching_interaction)
      end

    end

    context 'in all cases' do
      before { subject.find request }

      it 'adds the request to the list of requests' do
        expect(subject.requests).to include(request)
      end
    end

    context 'when no response was found' do

      before do
        subject.add double('non matching interaction', :match_request? => false)
      end

      it 'finds nothing' do
        expect(subject.find(request)).to be_nil
      end

      it 'adds nothing to the request' do
        subject.find request
        expect(request).to_not have_received(:interaction=)
      end

    end
  end

  context 'unmatched requests' do
    let(:unmatched_request) { double('unmatched_request', :interaction => nil)}

    before do
      allow(request).to receive(:interaction).and_return 'interaction'
      subject.requests << request
      subject.requests << unmatched_request
    end

    it 'includes requests that have no interaction' do
      expect(subject.unmatched_requests).to eq([unmatched_request])
    end
  end

  context 'deleting all interactions' do

    before do
      subject.add double('interaction')
      subject.add double('interaction 2')
      subject.requests << request

      subject.delete_all
    end

    it 'removes all interactions' do
      expect(subject.interactions).to be_empty
    end

    it 'removes all requests' do
      expect(subject.requests).to eq([])
    end
  end

  context 'adding a new interaction' do

    let(:interaction) { double 'interaction' }

    before do
      subject.add interaction
    end

    it 'adds the interaction to the list' do
      expect(subject.interactions).to include(interaction)
    end
  end
end