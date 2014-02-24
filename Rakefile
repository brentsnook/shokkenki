require 'rubygems'
require 'bundler'
require 'cucumber/rake/task'
require_relative 'lib/shokkenki/version'

Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake'

desc 'Push features to shokkenki project site for current version of shokkenki'
task :relish do
  sh "relish push shokkenki/shokkenki:#{Shokkenki::Version::STRING.split('.')[0..1].join('.')}"
end

desc 'Push documentation to shokkenki publisher site'
task :relish_publisher do
  sh 'cd publisher && relish push:publisher shokkenki'
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end