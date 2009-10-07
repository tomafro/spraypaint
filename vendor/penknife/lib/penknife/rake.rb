require 'penknife'

begin
  rspec_base = File.expand_path("#{RAILS_ROOT}/vendor/plugins/rspec/lib")
  $LOAD_PATH.unshift(rspec_base) if File.exist?(rspec_base) && !$LOAD_PATH.include?(rspec_base)
  require 'spec/rake/spectask'
rescue Object => e
end

module Penknife::Rake
  def self.define_plugin_tasks_for(plugin)
    plugin = plugin.to_s
    plugin_path = "#{RAILS_ROOT}/vendor/plugins/#{plugin}"
    
    namespace plugin do
      if Object.const_defined?(:Spec)
        desc "Run #{plugin} specs"
        Spec::Rake::SpecTask.new(:spec => "db:test:prepare") do |t|
          t.spec_opts = ["-f n -c"]
          t.spec_files = FileList["#{plugin_path}/spec/**/*_spec.rb"]
        end
      else
        task :spec do
          puts "To run specs for #{plugin} you must install rspec"
        end
      end
      
      desc "#{plugin.titleize} stats"
      task :stats do
        require 'code_statistics'
        ::CodeStatistics::TEST_TYPES << "#{plugin.titleize} specs"
        directories = [
          [plugin.titleize + " code", "lib"],
          [plugin.titleize + " specs", "spec"]
        ].collect { |name, dir| 
          [name, File.expand_path(File.join(plugin_path, dir))]}.select { |name, dir| File.directory?(dir) }
        CodeStatistics.new(*directories).to_s
      end
    end
  end
end