module Spraypaint::Behaviour::Manipulation
  def self.included(base)
    unless base == parent
      base.alias_method_chain :read_attribute, :spraypaint
      base.alias_method_chain :create_or_update, :spraypaint
      base.extend ClassMethods
    end
  end

  def tags
    read_attribute('tags')
  end
  
  def tags=(tags)
    write_attribute('tags', self.class.tag_sanitizer.sanitize([*tags]))
  end
  
  def tag_string
    read_attribute('tag_string') || tags.join(", ")
  end
  
  def tag_string=(string)
    write_attribute('tag_string', string)
    self.tags = string && string.split(",").collect(&:strip)
  end
  
  def tags_changed?
    attribute_changed?('tags')
  end

  def tags_change
    attribute_change('tags')
  end

  def tags_was
    attribute_was('tags')
  end
  
  def tags_will_change!
    attribute_will_change('tags')
  end
  
  private
  
  def create_or_update_with_spraypaint
    change = tags_change
    returning create_or_update_without_spraypaint do |result|
      if result && change
        save_tag_names(change.last)
      end
    end 
  end
  
  def read_attribute_with_spraypaint(attribute)
    if attribute.to_s == "tags"
      read_attribute_without_spraypaint(attribute) || load_tag_names
    else
      read_attribute_without_spraypaint(attribute)
    end
  end
  
  module ClassMethods
    def tag_sanitizer
      @tag_sanitizer ||= Spraypaint::DefaultSanitizer.new
    end
    
    def tag_sanitizer=(sanitizer)
      @tag_sanitizer = sanitizer
    end
  end
end