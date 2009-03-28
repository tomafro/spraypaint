# Simplified environment file, only meant for testing spraypaint

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# This plugin locator will only find the plugin we wish to test

class SinglePluginLocator < Rails::Plugin::FileSystemLocator
  def plugins
    if plugin = create_plugin(File.expand_path(File.join(File.dirname(__FILE__), '..', '..')))
      [plugin]
    else
      raise "Plugin to be tested couldn't be found"
    end
  end
end

Rails::Initializer.run do |config|
  # Change the plugin path to the grandparent folder, where the plugin to be tested actually resides  
  config.plugin_locators = [SinglePluginLocator]

  # Spraypaint only touches ActiveRecord, so don't bother loading any other frameworks
  config.frameworks = [:active_record]
end
