require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :test do |t|
  t.rspec_opts = "-fn"
  t.pattern = "./test/rspec{,/*/**}/*_spec.rb"
end

task :default => :test
