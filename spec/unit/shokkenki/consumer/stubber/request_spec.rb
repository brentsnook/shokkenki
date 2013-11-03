require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/request'

describe Shokkenki::Consumer::Stubber::Request do

  context 'created from a rack env' do

    subject do
      Shokkenki::Consumer::Stubber::Request.from_rack({
        'PATH_INFO' => '/thingo',
        'REQUEST_METHOD' => 'GET',
        'HTTP_ACCEPT' => 'application/json',
        'QUERY_STRING' => 'a=value&b=%26%26%26',
        'CONTENT_TYPE' => 'application/json',
        'rack.multithread' => false,
        'rack.input' => StringIO.new('I am the body'),
        'async.callback' => 'callback'
      })
    end

    it 'has the path' do
      expect(subject.path).to eq('/thingo')
    end

    it 'has the method' do
      expect(subject.method).to eq('get')
    end

    it 'has the body' do
      expect(subject.body).to eq('I am the body')
    end

    describe 'query' do
      it 'includes all query parameters' do
        expect(subject.query.keys.sort).to eq([:a, :b])
      end

      it 'has values URL decoded' do
        expect(subject.query[:b]).to eq('&&&')
      end
    end

    describe 'headers' do

      it 'includes anything that is not method, path or query' do
        expect(subject.headers).to include({:'content-type' => 'application/json'})
        expect(Set.new(subject.headers.keys) & Set.new([:'path-info', :'request-method', :'query-string'])).to eq(Set.new)
      end

      it 'includes HTTP prefixed headers' do
        expect(subject.headers).to include({:accept => 'application/json'})
      end

      it 'does not include rack variables' do
        expect(subject.headers.keys.select{|k| k.to_s.start_with?('rack.')}).to eq([])
      end

      it 'does not include async variables' do
        expect(subject.headers.keys.select{|k| k.to_s.start_with?('async.')}).to eq([])
      end

      describe 'name' do
        subject do
          Shokkenki::Consumer::Stubber::Request
        end

        it 'does not start with HTTP_' do
          expect(subject.as_header_name(:'HTTP_blah')).to eq(:blah)
        end

        it 'is lower case' do
          expect(subject.as_header_name(:'THING')).to eq(:thing)
        end

        it 'is a symbol' do
          expect(subject.as_header_name('thing')).to eq(:thing)
        end

        it 'contains hyphens instead of underscores as per HTTP header names' do
          expect(subject.as_header_name(:content_type)).to eq(:'content-type')
        end
      end
    end

  end

  context 'when created' do

    subject do
      Shokkenki::Consumer::Stubber::Request.new(
        :path => '/path',
        :body => 'body',
        :method => :get,
        :query => {'paramname' => 'value'},
        :headers => {'Content-Type' => 'application/json'}
      )
    end

    it 'has the given path' do
      expect(subject.path).to eq('/path')
    end

    it 'has the given method' do
      expect(subject.method).to eq(:get)
    end

    it 'has the given body' do
      expect(subject.body).to eq('body')
    end

    it 'has the given headers' do
      expect(subject.headers).to eq('Content-Type' => 'application/json')
    end

    it 'has the given query' do
      expect(subject.query).to eq('paramname' => 'value')
    end
  end

  context 'as a hash' do
    let(:hash) do
      Shokkenki::Consumer::Stubber::Request.new(
        :path => '/path',
        :body => 'body',
        :method => :get,
        :query => {'paramname' => 'value'},
        :headers => {'Content-Type' => 'application/json'}
      ).to_hash
    end

    it 'has the path' do
      expect(hash[:path]).to eq('/path')
    end

    it 'has the method' do
      expect(hash[:method]).to eq(:get)
    end

    it 'has the body' do
      expect(hash[:body]).to eq('body')
    end

    it 'has the headers' do
      expect(hash[:headers]).to eq('Content-Type' => 'application/json')
    end

    it 'has the query' do
      expect(hash[:query]).to eq('paramname' => 'value')
    end
  end
end