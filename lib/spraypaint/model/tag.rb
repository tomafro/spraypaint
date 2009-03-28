class Spraypaint::Model::Tag < ActiveRecord::Base
  # By default spraypaint uses the spraypaint namespace for all its tables, so
  # the tags themselves are stored in spraypaint_tags.  To change this, simply
  # set the table name to something else
  #   Spraypaint::Model::Tag.set_table_name 'special_tags'
  set_table_name :spraypaint_tags
  
  # All tags must have a name. In practise this is enforced by the way tags are 
  # set and in the database, so this validation is redundant in normal usage
  validates_presence_of :name
  
  def self.tag_condition(tag)
    sanitize_sql(:name => tag)
  end
end