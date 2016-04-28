require 'bundler/setup'
require "rspec/core/rake_task"
require "./lib/sharing_counter/version"

def name
  @name ||= Dir['*.gemspec'].first.split('.').first
end

def version
  SharingCounter::VERSION
end

def gemspec_file
  "#{name}.gemspec"
end

def gem_file
  "#{name}-#{version}.gem"
end

Bundler.require

desc 'Default: run spec tests.'
task :default => :spec

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = Dir.glob(['spec/sharing_counter/*'])
  spec.rspec_opts = ['--backtrace']
end

desc "Create tag v#{version}, build the gem and push to Git"
task :release => :build do
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  sh "git tag v#{version}"
  sh "git push origin master --tags"
end

desc "Build #{gem_file} into the pkg/ directory"
task :build do
  sh "mkdir -p pkg"
  sh "gem build #{gemspec_file}"
  sh "mv #{gem_file} pkg"
  sh "bundle --local"
end
