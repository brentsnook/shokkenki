require 'shokkenki/provider/rspec'

class ProviderApp

  attr_writer :weather, :temperature

  def call env
    env['PATH_INFO'] == '/weather' ? [200, {}, [%Q{{"message":"its a #{@weather} day, #{@temperature} degrees"}}]] : [404, {}, []]
  end
end

app = ProviderApp.new

Shokkenki.provider.configure do
  tickets ENV['ticket_directory']
  provider(:my_provider) do
    run app

    given /weather is (cold)/ do |args|
      app.temperature = args[:arguments][:temperature]
      app.weather = args[:match][1]
    end
  end
end

Shokkenki.provider.redeem_tickets