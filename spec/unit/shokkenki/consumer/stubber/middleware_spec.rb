require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/middleware'

describe Shokkenki::Consumer::Stubber::Middleware do

  let(:application) { double('application').as_null_object }

  subject { Shokkenki::Consumer::Stubber::Middleware.new application }

  let(:response) { subject.call(env) }

  context 'when called' do

    context 'when the request is to identify its self' do
      let(:env) { {'PATH_INFO' => Shokkenki::Consumer::Stubber::Middleware::IDENTIFY_PATH} }

      it 'identifies using the object ID of the wrapped application' do
        expect(response[2]).to eq([application.object_id.to_s])
      end

      it 'is successful' do
        expect(response[0]).to eq(200)
      end
    end

    context 'when the wrapped application fails' do

      let(:env) { {'PATH_INFO' => '/'} }

      before do
        allow(application).to receive(:call).and_raise 'kaboom'
      end

      it 'stores the error for reference' do
        response rescue
        expect(subject.error.message).to eq('kaboom')
      end

      it 'fails' do
        expect { response }.to raise_error('kaboom')
      end

      it 'avoid clobbering existing errors' do
        subject.error = 'I was here first!'
        response rescue
        expect(subject.error).to eq('I was here first!')
      end
    end

    context 'with any other request' do

      let(:env) { {'PATH_INFO' => '/otherpath'} }

      it 'calls the wrapped application' do
        response
        expect(application).to have_received(:call).with(env)
      end
    end
  end
end