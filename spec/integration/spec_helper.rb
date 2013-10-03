require 'rubygems'

def run_spec spec, environment
  raise 'Could not run spec' unless system(environment, "bundle exec rspec -f progress #{spec}")
end