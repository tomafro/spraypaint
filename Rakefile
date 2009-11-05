$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))

require 'spraypaint/version'
require 'spec/rake/spectask' rescue nil

namespace :spraypaint do
  begin
    require 'jeweler'
    Jeweler::Tasks.new do |gemspec|
      gemspec.name = "spraypaint"
      gemspec.version = Spraypaint::Version::STRING
      gemspec.summary = "Simple tagging plugin for rails"
      gemspec.description = "Simple tagging in a can"
      gemspec.email = "tom@popdog.net"
      gemspec.homepage = "http://github.com/tomafro/spraypaint.git"
      gemspec.authors = ['Tom Ward']
    end
  rescue LoadError
    puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
  end
  
  if Object.const_defined?(:Spec)
    desc "Run specs for spraypaint"
    Spec::Rake::SpecTask.new(:spec) do |t|
      t.spec_opts = ["-f n -c"]
      t.spec_files = FileList["#{File.dirname(__FILE__)}/test/spec/**/*_spec.rb"]
    end
  else
    task :spec do
      puts "To run specs for spraypaint you must install rspec"
    end
  end
  
  task 'about.yml' do
    gemspec = Rake.application.jeweler_tasks.jeweler.gemspec
    File.open(File.join(File.dirname(__FILE__), "about.yml"), 'w+') do |f|
      YAML.dump({
        :name => gemspec.name,
        :summary => gemspec.summary,
        :email => 'tom@popdog.net',
        :homepage => gemspec.homepage,
        :author => gemspec.authors.join(", "),
        :plugin => gemspec.homepage,
        :license => 'MIT',
        :rails_version => '2.3+',
        :version => gemspec.version.to_s
      }, f)
    end
  end
end

task 'default' => ['spraypaint:spec', 'spraypaint:features']
