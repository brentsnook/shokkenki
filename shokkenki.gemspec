# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'shokkenki/version'

Gem::Specification.new do |s|
  s.name = 'shokkenki'
  s.version = Shokkenki::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.license = 'GPL2'
  s.authors = ['Brent Snook']
  s.email = 'brent@fuglylogic.com'
  s.homepage = 'http://github.com/brentsnook/shokkenki'
  s.summary = "shokkenki-#{Shokkenki::Version::STRING}"
  s.description = 'Example-driven consumer-driven contracts.'

  s.files = `git ls-files -- lib/*`.split("\n")
  s.test_files = s.files.grep(%r{^spec/})
  s.rdoc_options = ['--charset=UTF-8']
  s.require_path = 'lib'

  s.required_ruby_version = '>= 1.9'

  s.add_runtime_dependency 'shokkenki-consumer', '0.0.4'
  s.add_runtime_dependency 'shokkenki-provider', '0.0.4'

  s.add_development_dependency 'rake', '~> 10.0.0'
end