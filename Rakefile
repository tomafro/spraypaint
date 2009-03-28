require 'rubygems'
require 'penknife'
require 'penknife/plugin/rake'
RAILS_ROOT = File.join(File.dirname(File.expand_path(__FILE__)), "test")
Penknife::Plugin::Rake.define_plugin_tasks_for(:spraypaint, RAILS_ROOT)

task :default => 'spraypaint:spec'

folders = %w{rails lib recipes tasks spec features}.collect {|f| "#{f}/**/*"}

GEM_FILES = FileList[
  *['[a-zA-Z]*', folders] 
]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
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
