class <%= class_name.underscore.camelize %> < ActiveRecord::Migration
  def self.up
    create_table 'spraypaint_tags', :force => true do |table|
      table.string 'name' :null => false
    end
    
    add_index 'spraypaint_tags', 'name', :unique => true
    
    create_table 'spraypaint_taggings', :force => true do |table|
      table.integer 'spraypaint_tag_id', :null => false
      table.integer 'taggable_id', :null => false
      table.string 'taggable_type', :null => false
    end

    add_index 'spraypaint_taggings', 'target_id'
    add_index 'spraypaint_taggings', 'target_type'
    add_index 'spraypaint_taggings', 'spraypaint_tag_id'
    add_index 'spraypaint_taggings', ['taggable_type', 'taggable_id', 'spraypaint_tag_id'], :unique => true, :name => 'spraypaint_unique_tagging_index'
  
    create_table spraypaint_tagging_counts, :defaults => false, :force => true do |table|
      table.string 'spraypaint_tag_name', :null => false
      table.integer 'spraypaint_tag_id', :null => false
      table.string 'taggable_type'
      table.integer 'spraypaint_tag_count', :default => 0
    end
    
    add_index 'spraypaint_tagging_counts', 'spraypaint_tag_id'
    add_index 'spraypaint_tagging_counts', 'taggable_type'
    add_index 'spraypaint_tagging_counts', 'spraypaint_tag_count'
    add_index 'spraypaint_tagging_counts', ['taggable_type', 'spraypaint_tag_id'], :unique => true, :name => 'spraypaint_unique_tagging_count_index'
  end
  
  def self.down
    drop_table 'spraypaint_tagging_counts' rescue nil
    drop_table 'spraypaint_taggings' rescue nil
    drop_table 'spraypaint_tags' rescue nil
  end
end
