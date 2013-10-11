require 'shokkenki/consumer/session'

module Shokkenki

  def self.consumer
    @consumer_session ||= Shokkenki::Consumer::Session.new
  end

end