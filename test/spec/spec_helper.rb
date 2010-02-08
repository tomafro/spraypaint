ENV["RAILS_ENV"] = "test"
RAILS_ENV = "test"

require 'active_record'
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:",
  pool: 5,
  timeout: 5000
) 
require File.expand_path(File.dirname(__FILE__) + '/../db/schema')
require 'spraypaint'

Spraypaint.activate_plugin

module ActsAsFu
  def build_model(name, options={}, &block)
    klass_name  = name.to_s.classify
    super_class = options[:superclass] || ActiveRecord::Base
    contained   = options[:contained]  || Object
 
    contained.send(:remove_const, klass_name) rescue nil
    klass = Class.new(super_class)
    contained.const_set(klass_name, klass)
 
    # table_name isn't available until after the class is created.
    if super_class == ActiveRecord::Base
      ActiveRecord::Base.connection.create_table(klass.table_name, :force => true) { }
    end
 
    model_eval(klass, &block)
    klass
  end
 
  private
 
  def model_eval(klass, &block)
    class << klass
      def method_missing_with_columns(sym, *args, &block)
        ActiveRecord::Base.connection.change_table(table_name) do |t|
          t.send(sym, *args)
        end
      end
 
      alias_method_chain :method_missing, :columns
    end
 
    klass.class_eval(&block) if block_given?
 
    class << klass
      alias_method :method_missing, :method_missing_without_columns
    end
  end

end

Spec::Runner.configure do |config|
  include ActsAsFu
end
