require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
  t.warning = true
  t.ruby_opts = ['-Eascii-8bit:ascii-8bit']
end
