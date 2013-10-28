require_relative 'harness_helper'
require 'shokkenki/consumer/rspec'
require 'httparty'

Shokkenki.consumer.configure do |c|
  c.ticket_location = ENV['ticket_directory']
  c.define_provider(:my_provider) do |p|
    p.stub_with :local_server
  end
end

describe 'A consumer', :shokkenki_consumer => {:name => :my_consumer} do

  context 'when a simple request is stubbed' do
    before do
      order(:my_provider).during('a greeting').to do
        receive(:path => '/greeting').
        and_respond(
          :status => 200,
          :body => /hello/
        )
      end
    end

    it 'receives the stubbed response' do
      stubber = shokkenki.provider(:my_provider).stubber
      url = "http://#{stubber.host}:#{stubber.port}/greeting"
      expect(HTTParty.get(url).body).to match(/hello/)
    end
  end
end