class <%= class_name.underscore.camelize %> < ActiveRecord::Migration
  def self.up
    create_table '<%= tags_table %>', :force => true do |table|
      table.string 'name', :null => false
    end
    
    add_index '<%= tags_table %>', 'name', :unique => true
    
    create_table '<%= taggings_table %>', :force => true do |table|
      table.integer 'spraypaint_tag_id', :null => false
      table.integer 'target_id', :null => false
      table.string 'target_type', :null => false
    end

    add_index '<%= taggings_table %>', 'target_id'
    add_index '<%= taggings_table %>', 'target_type'
    add_index '<%= taggings_table %>', 'spraypaint_tag_id'
    add_index '<%= taggings_table %>', ['target_type', 'target_id', 'spraypaint_tag_id'], :unique => true, :name => 'spraypaint_unique_tagging_index'
  end
  
  def self.down
    drop_table '<%= taggings_table %>'
    drop_table '<%= tags_table %>'
  end
end
