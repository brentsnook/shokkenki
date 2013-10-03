# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'shokkenki/version'

Gem::Specification.new do |s|
  s.name = 'shokkenki'
  s.version = Shokkenki::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.license = 'MIT'
  s.authors = ['Brent Snook']
  s.email = 'brent@fuglylogic.com'
  s.homepage = 'http://github.com/brentsnook/shokkenki'
  s.summary = "shokkenki-#{Shokkenki::Version::STRING}"
  s.description = 'Consumer-driven contracts recorded from real examples.'

  s.files = `git ls-files -- lib/*`.split("\n")
  s.test_files = s.files.grep(%r{^spec/})
  s.rdoc_options = ['--charset=UTF-8']
  s.require_path = 'lib'

  s.required_ruby_version = '>= 1.8.7'

  s.add_runtime_dependency 'json'

  s.add_development_dependency 'rake', '~> 10.0.0'
  s.add_development_dependency 'rspec', '~> 2.14.0'
  s.add_development_dependency 'json'
  s.add_development_dependency 'timecop'
end