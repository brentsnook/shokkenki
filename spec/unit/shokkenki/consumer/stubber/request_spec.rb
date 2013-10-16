require_relative '../../../spec_helper'
require 'shokkenki/consumer/stubber/request'

describe Shokkenki::Consumer::Stubber::Request do

  context 'created from a rack env' do
    it 'has the path'
    it 'has the method'
    it 'has the headers'
    it 'has the query parameters'
    it 'has the query string'
    it 'has the body'
    it 'has all HTTP variables'
  end

  context 'as hash' do
    it 'has the path'
    it 'has the method'
    it 'has the headers'
    it 'has the body'
    it 'has the query parameters'
    it 'has the query string'
    it 'has all HTTP variables'
  end
end