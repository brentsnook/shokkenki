require 'rubygems'
require 'bundler'
require 'cucumber/rake/task'
require_relative 'lib/shokkenki/version'

Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake'

desc 'Push features to shokkenki project site for current version of shokkenki'
task :relish do
  sh "relish push shokkenki/shokkenki:#{Shokkenki::Version::STRING} path shokkenki-features"
end

desc 'Push documentation to shokkenki publisher site'
task :relish_publisher do
  sh 'relish push:publisher shokkenki'
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "shokkenki-features --format pretty" # we need to use a different name because relish publish task doesn't support supplying a directory
end