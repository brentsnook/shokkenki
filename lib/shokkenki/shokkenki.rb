require 'shokkenki/configuration'

module Shokkenki

  def self.configuration
    @configuration ||= Shokkenki::Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end
end