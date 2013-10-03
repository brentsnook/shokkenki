require 'rubygems'

def project_root
  File.join(File.dirname(__FILE__), '..')
end

lib_dir = File.expand_path(File.join(project_root, 'lib'))
$:.unshift lib_dir # ensure lib directory used before installed gems