require_relative 'harness_helper'
require 'shokkenki/consumer/rspec'

Shokkenki.consumer.configure do |c|
  c.ticket_location = ENV['ticket_directory']
  # c.add_provider(:my_provider) do |p|
  #   p.stub_with(:remote,
  #     :host => 'localhost',
  #     :port => 1234
  #   )
  # end
end

describe 'A consumer', :shokkenki_consumer => {:name => :my_consumer} do

  before do
    shokkenki.order do
      provider :my_provider
      during 'a greeting'
      requested_with(
        :path => '/greeting'
      )
      responds_with(
        :body => /hello/
      )
    end
  end

  it 'runs successfully' do
    expect(true).to be_true
  end
end