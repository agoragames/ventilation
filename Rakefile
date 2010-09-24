require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ventilation"
    gem.summary = %Q{Fancy ESI integration for your high prefomance web apps.}
    gem.description = %Q{Helper methods for building esi tags, simplifies development bypassing the need for varnish.}
    gem.email = "btaylor@agoragames.com"
    gem.homepage = "http://github.com/agoragames/ventilation"
    gem.authors = ["Blake Taylor"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_development_dependency "fakeweb", ">= 1.2.8"
    gem.add_development_dependency "mocha", ">= 0.9.8"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

desc 'Test ventilation.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Default: run unit tests.'
task :default => :test

task :test => :check_dependencies

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ventilation #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
