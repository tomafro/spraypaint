ENV["RAILS_ENV"] = "test"
require File.expand_path(File.join(File.dirname(__FILE__), '../config/environment.rb'))
require File.expand_path(File.dirname(__FILE__) + '/../db/schema')

require 'spec/rails'

def redefine_models
  redefine_classes(:Book, :Film, :superclass => ActiveRecord::Base)
  redefine_classes(:Novel, :NonFiction, :superclass => Book)
end

def redefine_classes(*classes)
  options = classes.last.is_a?(Hash) ? classes.pop : {}
  classes.each do |class_name|
    Object.remove_class(class_name.to_s.constantize) if Object.const_defined?(class_name)
    Object.const_set(class_name, Class.new(options[:superclass] || Object))
  end
end