class Spraypaint::Model::Tagging < ActiveRecord::Base
  set_table_name :spraypaint_taggings
  
  # Main association between an individual tagging and the actual tag
  belongs_to :tag, :class_name => 'Spraypaint::Model::Tag'
  
  # Association between the tagging and the object being tagged
  belongs_to :target, :polymorphic => true
  
  validates_presence_of :tag, :target
end