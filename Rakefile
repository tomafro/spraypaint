require 'rubygems'

begin
  require 'penknife'
  require 'penknife/plugin/rake'
  RAILS_ROOT = File.join(File.dirname(File.expand_path(__FILE__)), "test")
  Penknife::Plugin::Rake.define_plugin_tasks_for(:spraypaint, RAILS_ROOT)

  task :default => 'spraypaint:spec'
rescue LoadError
  puts "Penknife gem isn't available. Install it with: sudo gem install tomafro-penknife -s http://gems.github.com"
end

folders = %w{rails lib recipes tasks spec features}.collect {|f| "#{f}/**/*"}

GEM_FILES = FileList[
  *['[a-zA-Z]*', folders] 
]

begin
  require 'jeweler'
  jeweler = Jeweler::Tasks.new do |gem|
    gem.name = "spraypaint"
    gem.summary = %{Rails tagging in a can}
    gem.email = "tom@popdog.net"
    gem.homepage = "http://github.com/tomafro/spraypaint"
    gem.authors = ["Tom Ward"]
    gem.files = GEM_FILES.to_a
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

task :"about.yml" do
  File.open(File.join(File.dirname(File.expand_path(__FILE__)), "about.yml"), 'w+') do |f|
    YAML.dump({
      :name => jeweler.gemspec.name,
      :summary => jeweler.gemspec.summary,
      :email => jeweler.gemspec.email,
      :homepage => jeweler.gemspec.homepage,
      :author => 'Tom Ward (tomafro)',
      :plugin => 'http://github.com/tomafro/spraypaint.git',
      :license => 'MIT',
      :rails_version => '2.3+',
      :version => jeweler.jeweler.version
    }, f)
  end
end