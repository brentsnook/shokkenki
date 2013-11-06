require 'shokkenki/provider/rspec'

class ProviderApp
  def call env
    [200, {}, []]
  end
end

Shokkenki.provider.honour_tickets do |t|
  t.ticket_location = ENV['ticket_directory']
  t.provider(:my_provider) do
    racked_up { ProviderApp.new }
  end
end