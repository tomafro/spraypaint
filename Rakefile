$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$: << File.expand_path(File.join(File.dirname(__FILE__), "vendor/penknife/lib"))

require 'penknife/rake/plugin_tasks'

namespace :spraypaint do
  Penknife::Rake::PluginTasks.new do |plugin|
    plugin.plugin_root = File.dirname(File.expand_path(__FILE__))
    plugin.name = 'spraypaint'
    plugin.summary = 'Simple tagging in a can'
    plugin.authors = ['Tom Ward (tomafro)']
    plugin.email = 'tom@popdog.net'
    plugin.homepage = 'http://github.com/tomafro/spraypaint'
    plugin.code = 'http://github.com/tomafro/spraypaint.git'
    plugin.license = 'MIT'
    plugin.rails_version = '2.3+'
    plugin.files = `git ls-files`.split("\n")
  end
end

task 'default' => ['spraypaint:spec', 'spraypaint:features']
