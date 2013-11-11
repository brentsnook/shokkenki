require 'shokkenki/provider/rspec'

class ProviderApp
  def call env
    env['PATH_INFO'] == '/greeting' ? [200, {}, ['why hello there']] : [404, {}, []]
  end
end

Shokkenki.provider.configure do
  tickets ENV['ticket_directory']
  provider(:my_provider) do
    run ProviderApp.new
  end
end

Shokkenki.provider.redeem_tickets