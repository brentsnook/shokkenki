require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/server'
require 'shokkenki/consumer/stubber/server_application_error'

describe Shokkenki::Consumer::Stubber::ServerApplicationError do

  let(:wrapped_backtrace) { ['wrapped 1', 'wrapped 2'] }
  let(:error) do
    error = Exception.new 'wrapped error message'
    error.set_backtrace wrapped_backtrace
    error
  end

  subject { Shokkenki::Consumer::Stubber::ServerApplicationError.new error }

  describe 'backtrace' do

    before do
      subject.set_backtrace ['server application 1', 'server application 2']
    end

    it 'starts with the wrapped error backtrace' do
      expect(subject.backtrace.slice(0..1)).to eq(['wrapped 1', 'wrapped 2'])
    end

    it 'end with the location where the error was created' do
      expect(subject.backtrace.slice(wrapped_backtrace.length..-1)).to eq(['server application 1', 'server application 2'])
    end

    context 'when wrapped error has no backtrace' do
      let(:error) do
        error = Exception.new
        error.set_backtrace nil
        error
      end

      it 'has only the location backtrace' do
        expect(subject.backtrace).to eq(['server application 1', 'server application 2'])
      end
    end
  end

  describe 'message' do
    it 'mentions that an error occurred in the stub server' do
      expect(subject.message).to match(/^An error occurred in the stub server: /)
    end
    it 'includes the wrapped error message' do
      expect(subject.message).to match(/wrapped error message$/)
    end
  end
end