require 'rubygems'
require 'bundler'
require 'cucumber/rake/task'

Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake'

desc 'Push features to shokkenki publisher site'
task :relish do
  sh 'relish push:publisher shokkenki'
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end