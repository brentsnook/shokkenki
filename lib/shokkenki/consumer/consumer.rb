require_relative 'core_ext/string'
require_relative 'core_ext/hash'
require_relative 'core_ext/regexp'
require_relative 'core_ext/symbol'
require_relative 'core_ext/numeric'

require_relative 'session'

module Shokkenki

  def self.consumer
    @consumer_session ||= Shokkenki::Consumer::Session.new
  end

end