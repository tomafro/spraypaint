require 'spraypaint'

class SpraypaintMigrationGenerator < Rails::Generator::NamedBase  
  def initialize(runtime_args, runtime_options)
    super(["create_spraypnt_tagging_tables"], runtime_options)
  end
  
  def manifest
    record do |m|
      m.migration_template 'spraypaint_migration.rb', 'db/migrate'
    end
  end
  
  def tags_table
    Spraypaint::Model::Tag.table_name
  end
  
  def taggings_table
    Spraypaint::Model::Tagging.table_name
  end
end
