$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))

require 'spraypaint/version'
require 'spec/rake/spectask' rescue nil

SPRAYPAINT_ROOT = File.dirname(__FILE__)

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
    
    Jeweler::GemcutterTasks.new
  rescue LoadError
    puts "Jeweler not available. Install it with: gem install jeweler"
  end
  
  if Object.const_defined?(:Spec)
    desc "Run specs for spraypaint"
    Spec::Rake::SpecTask.new(:spec) do |t|
      t.spec_opts = ["-f n -c"]
      t.spec_files = FileList["#{SPRAYPAINT_ROOT}/test/spec/**/*_spec.rb"]
    end
  else
    task :spec do
      puts "To run specs for spraypaint you must install rspec"
    end
  end
  
  task 'about.yml' do
    gemspec = Rake.application.jeweler_tasks.jeweler.gemspec
    File.open(File.join(SPRAYPAINT_ROOT, "about.yml"), 'w+') do |f|
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
  
  task 'tag' do
    gemspec = Rake.application.jeweler_tasks.jeweler.gemspec    
    `cd #{SPRAYPAINT_ROOT}; git tag -a "v#{gemspec.version.to_s}" -m "Releasing spraypaint version #{gemspec.version.to_s}"`
  end
  
  task 'release' => ['spraypaint:spec', 'spraypaint:about.yml', 'spraypaint:tag', 'spraypaint:gemcutter:release']
end

task 'default' => ['spraypaint:spec', 'spraypaint:features']
