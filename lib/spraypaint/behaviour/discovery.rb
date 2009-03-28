module Spraypaint::Behaviour::Discovery
  def self.included(base)
    unless base == parent
      base.named_scope :tagged_with, lambda {|*tag|
        tags = [*tag].collect do |t|
          base.tag_sanitizer.sanitize(t)
        end.compact.uniq
        {:conditions => %{
          EXISTS (
            SELECT 1 FROM #{Spraypaint::Model::Tag.table_name}, #{Spraypaint::Model::Tagging.table_name}
            WHERE #{Spraypaint::Model::Tagging.table_name}.target_id = #{base.table_name}.id
            AND #{Spraypaint::Model::Tagging.table_name}.target_type = '#{base.base_class.name}'
            AND #{Spraypaint::Model::Tag.table_name}.id = #{Spraypaint::Model::Tagging.table_name}.tag_id            
            AND (#{Spraypaint::Model::Tag.tag_condition(tags)})
            GROUP BY #{Spraypaint::Model::Tagging.table_name}.target_id 
            HAVING count(distinct #{Spraypaint::Model::Tagging.table_name}.tag_id) = #{tags.size} 
          )
        }}
      }
      
      base.extend(ClassMethods)
    end
  end
  
  module ClassMethods
    class TagString < String
      def initialize(string, count)
        super(string)
        @tag_count = count.to_i
      end
      
      def frequency
        @tag_count
      end
    end
    
    def tags(options = {})
      
      self.all({
        :select => ['spraypaint_tags.id, spraypaint_tags.name tag_name, count(*) tag_count'],
        :joins => %{
          INNER JOIN spraypaint_taggings ON (spraypaint_taggings.target_id = #{self.table_name}.#{self.primary_key} AND spraypaint_taggings.target_type = '#{self.base_class.name}')
          INNER JOIN spraypaint_tags ON (spraypaint_tags.id = spraypaint_taggings.tag_id)
        },
        :group => 'spraypaint_tags.id',
        :order => 'count(*) desc, spraypaint_tags.name', 
      }.merge(options.slice(:conditions, :limit, :offset, :order))).collect {|tag| TagString.new(tag.tag_name, tag.tag_count) }
    end
    
    def related_tags(*tags)
      options = tags.extract_options!
      tags(options)
    end
  end
end