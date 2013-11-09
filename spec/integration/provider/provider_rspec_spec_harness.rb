require 'shokkenki/provider/rspec'

class ProviderApp
  def call env
    [200, {}, []]
  end
end

Shokkenki.provider.redeem_tickets do |t|
  t.ticket_location = ENV['ticket_directory']
  t.provider(:my_provider) do
    app { ProviderApp.new }
  end
end