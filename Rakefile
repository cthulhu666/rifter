require 'bundler/gem_tasks'

Dir.glob('lib/tasks/*.rake').each {|r| import r}

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color'] #, '--format', 'nested']
end

task :default => :spec

