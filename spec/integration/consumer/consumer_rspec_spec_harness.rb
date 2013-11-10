require_relative '../harness_helper'
require 'shokkenki/consumer/rspec'
require 'httparty'

Shokkenki.consumer.configure do
  tickets ENV['ticket_directory']
  define_provider :my_provider
end

describe 'A consumer', :shokkenki_consumer => :my_consumer do

  context 'when a simple request is stubbed' do
    before do
      order(:my_provider).during('a greeting').to do
        given(:weather, :temperature => 30).
        receive(:path => '/greeting').
        and_respond(
          :status => 200,
          :body => /hello there, its a warm one today /
        )
      end
    end

    it 'receives the stubbed response' do
      stubber = shokkenki.provider(:my_provider).stubber
      url = "http://#{stubber.host}:#{stubber.port}/greeting"
      expect(HTTParty.get(url).body).to match(/hello there, its a warm one today/)
    end
  end
end