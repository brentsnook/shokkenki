require 'rubygems'
require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'rake'

desc 'Push features to shokkenki publisher site'
task :relish do
  sh 'relish push:publisher shokkenki'
end
