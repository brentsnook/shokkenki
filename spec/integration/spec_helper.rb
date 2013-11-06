require 'rubygems'
require 'open3'

def run_spec spec_args, environment
  stdin, stdout, stderr, wait_thr = Open3.popen3(environment, "bundle exec rspec #{spec_args}")
  exit_status = wait_thr.value
  stdin.close
  output = stdout.read
  stdout.close
  error = stderr.read
  stderr.close
  exit_status == 0 ? output : raise("Could not run spec:\nOutput: #{output}\nError: #{error}")
end