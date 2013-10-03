require_relative 'harness_helper'
require 'shokkenki/consumer/rspec'

describe 'A consumer', :shokkenki_consumer => {:name => :my_consumer} do

  before do
	  Shokkenki.configure do |config|
	    config.ticket_location = ENV['ticket_directory']
	  end

	  shokkenki.consumer.provider(:my_provider)
	end

	it 'runs successfully' do
	  expect(true).to be_true
	end
end