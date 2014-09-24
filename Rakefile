require "bundler"
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/lib/truevault/*_spec.rb']
  t.verbose = true
end

task :console do
  $LOAD_PATH << "./lib"

  require "irb"
  require "irb/completion"
  require "truevault.rb"

  ARGV.clear
  IRB.start
end

task :default => :test
