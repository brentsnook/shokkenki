require_relative '../../../spec_helper'
require 'shokkenki/consumer/dsl/http_methods'

describe Shokkenki::Consumer::DSL::HttpMethods do

  class HttpMethodsStub
    include Shokkenki::Consumer::DSL::HttpMethods
  end

  let(:details) { {:d => ''} }

  subject { HttpMethodsStub.new }

  before { allow(subject).to receive(:receive) }

  [:get, :put, :post, :head, :options, :delete].each do |meth|
    context meth do
      before { subject.send meth, '', details }
      it "requests as a #{meth}" do
        expect(subject).to have_received(:receive).with(hash_including(:method => meth))
      end
    end
  end

  context 'when a path is given' do
    before { subject.get '/path', details }
    it 'uses the given path' do
      expect(subject).to have_received(:receive).with(hash_including(:path => '/path'))
    end
  end

  context 'when a method is given' do
    before { subject.get '/', {:method => :post} }
    it 'overrides default method' do
      expect(subject).to have_received(:receive).with(hash_including(:method => :post))
    end
  end
end