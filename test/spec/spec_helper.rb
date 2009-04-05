ENV["RAILS_ENV"] = "test"
RAILS_ENV = "test"

require File.expand_path(File.join(File.dirname(__FILE__), '../config/environment.rb'))
require File.expand_path(File.dirname(__FILE__) + '/../db/schema')

require 'acts_as_fu'

Spec::Runner.configure do |config|
  config.include ActsAsFu
end

# 

class ActsAsFu::Connection
  def connection
    ActiveRecord::Base.connection
  end
end

ActsAsFu::Connection.connected = true