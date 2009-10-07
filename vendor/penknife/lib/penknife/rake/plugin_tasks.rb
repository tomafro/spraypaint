require 'penknife'
require 'penknife/rake'
require 'rake'
require 'rake/tasklib'
require 'activesupport'
require 'cucumber/rake/task'
require 'spec/rake/spectask'
require 'jeweler'
require 'date'

class Penknife::Rake::PluginTasks < Jeweler::Tasks
  def initialize(gemspec = nil, &block)
    @gemspec = gemspec || Gem::Specification.new()
    @gemspec.extend(PluginConfig)
    @gemspec.date = Date.today.to_s
    super(@gemspec)
  end
  
  module PluginConfig
    attr_accessor :plugin_root, :code, :license, :rails_version
  end
  
  private
  
  def define
    super
    plugin = @plugin_name.to_s
    
    if Object.const_defined?(:Spec)
      desc "Run specs for #{plugin} plugin "
      Spec::Rake::SpecTask.new(:spec) do |t|
        t.spec_opts = ["-f n -c"]
        t.spec_files = FileList["#{@gemspec.plugin_root}/test/spec/**/*_spec.rb"]
      end
    else
      task :spec do
        puts "To run specs for #{plugin} you must install rspec"
      end
    end
  
    desc "Run #{plugin} features"
    Cucumber::Rake::Task.new(:features) do |t|
      t.profile = ENV["CUCUMBER"] || "default"
    end

    desc "Calculate stats for #{plugin} plugin"
    task :stats do
      require 'code_statistics'
      ::CodeStatistics::TEST_TYPES << "#{@gemspec.name.titleize} specs"
      ::CodeStatistics::TEST_TYPES << "#{@gemspec.name.titleize} features"
      directories = [
        [@gemspec.name.titleize + " code", "lib"],
        [@gemspec.name.titleize + " specs", "test/spec"],
        [@gemspec.name.titleize + " features", "test/features"]
      ].collect { |name, dir| 
        [name, File.expand_path(File.join(@gemspec.plugin_root, dir))]}.select { |name, dir| File.directory?(dir) }
      CodeStatistics.new(*directories).to_s
    end
    
    desc "Build about.yml for current version"
    task :"about.yml" do
      File.open(File.join(@gemspec.plugin_root, "about.yml"), 'w+') do |f|
        YAML.dump({
          :name => @gemspec.name,
          :summary => @gemspec.summary,
          :email => @gemspec.email,
          :homepage => @gemspec.homepage,
          :author => @gemspec.authors.join(", "),
          :plugin => @gemspec.code,
          :license => @gemspec.license,
          :rails_version => @gemspec.rails_version,
          :version => @jeweler.version
        }, f)
      end
    end
    
    task 'generate' => ['gemspec', 'about.yml']
  end
end