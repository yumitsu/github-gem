require 'rubygems'
require 'stringio'

if File.exists?('github.gemspec')
  stdout, stderr = $stdout, $stderr
  $stdout, $stderr = StringIO.new, StringIO.new
  
  spec = eval(File.read('github.gemspec'))
  
  $stdout, $stderr = stdout, stderr
  
  spec.runtime_dependencies.each do |dep|
    begin
      cmd = "`which gem` install #{dep.name} --no-ri --no-rdoc --no-update-sources --version='#{dep.requirement}'"
      system(cmd)
    rescue
      raise "Execution failed with '#{cmd}' command"
    end
  end
else
  raise "No gem specification found"
end