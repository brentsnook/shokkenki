require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/restful_middleware'

describe Shokkenki::Consumer::Stubber::RestfulMiddleware do

  class SubclassMiddleware < Shokkenki::Consumer::Stubber::RestfulMiddleware
    get { |env| get_handler(env) }
    delete { |env| }
    post { |env| }
  end

  let(:call_response) { subject.call env }
  subject { SubclassMiddleware.new }

  context 'when called' do

    before { allow(subject).to receive(:get_handler) }

    context 'with a request that is handled' do

      let(:env) { {'REQUEST_METHOD' => 'GET'} }
      before { call_response }

      it 'calls the handler for that method' do
        expect(subject).to have_received(:get_handler).with env
      end

    end

    context "with a request that isn't handled" do

      let(:env) { {'REQUEST_METHOD' => 'NOTRECOGNISED'} }

      it 'returns a status to indicate that the method is not allowed (405)' do
        expect(call_response[0]).to eq(405)
      end

      it 'returns a list of the allowed methods' do
        expect(call_response[1]['Allow'].split(', ').sort).to eq(%w(DELETE GET POST))
      end
    end

  end
end