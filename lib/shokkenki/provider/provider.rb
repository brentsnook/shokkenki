require_relative 'session'

module Shokkenki

  def self.provider
    @provider_session ||= Shokkenki::Provider::Session.new
  end

end