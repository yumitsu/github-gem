require 'rubygems'
require 'fileutils'

if File.exists?('github.gemspec')
  spec = eval(File.read('github.gemspec'))
  
  spec.runtime_dependencies.each do |dep|
    begin
      cmd = "`which gem` install #{dep.name} --no-ri --no-rdoc --version='#{dep.requirement}'"
      system(cmd)
    rescue
      raise "Execution failed with '#{cmd}' command"
    end
  end
else
  raise "No gem specification found"
end