require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require 'cucumber'
require 'cucumber/rake/task'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "loris"
    gem.summary = 'Automatically run javascript unit tests'
    gem.description = 'Automatically run javascript unit tests'
    gem.email = "loris@monket.net"
    gem.homepage = "http://github.com/karl/loris"
    gem.authors = ["Karl O'Keeffe"]

    gem.add_dependency('visionmedia-bind', [">= 0.2.6"])
    gem.add_dependency('karl-growl', [">= 1.0.3"])
    gem.add_dependency('extensions', [">= 0.6.0"])
    gem.add_dependency('win32-process', [">= 0.6.1"])

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


task :default => :spec

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = Dir.glob('spec/**/*_spec.rb')
  # t.rcov = true
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end



