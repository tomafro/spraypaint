module Spraypaint::Behaviour::Persistence  
  def self.included(base)
    unless base == parent
      base.has_many 'spraypaint_taggings', :as => 'target', :dependent => :destroy, :class_name => 'Spraypaint::Model::Tagging'
      base.has_many 'spraypaint_tags', :through => 'spraypaint_taggings', :source => 'tag', :class_name => '::Spraypaint::Model::Tag', :order => 'spraypaint_taggings.id'
    end
  end
  
  private
  
  def load_tag_names
    self.spraypaint_tags.collect(&:name)
  end
  
  def save_tag_names(names)
    transaction do
      spraypaint_taggings.destroy_all
      names.each do |tag_name|
        tag = Spraypaint::Model::Tag.find_or_create_by_name(tag_name)
        self.spraypaint_tags << tag
      end
    end
  end
end