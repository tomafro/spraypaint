# = Spraypaint - simple tagging in a can
#
# == Getting started
#
# Generate and run the spraypaint migration
#   script/generate spraypaint_migration
#   rake db:migrate
#
# Enable spraypaint in a model
#   class Film < ActiveRecord::Base
#     tag_with_spraypaint
#
#     def inspect
#       "<#{self.title}>"
#     end
#   end
# 
# Create some tagged films:
#   Film.create! :title => 'The Umbrellas of Cherbourg', :director => 'Demy', :tags => ['umbrellas', 'french', 'musical']  
#   Film.create! :title => 'Jules Et Jim', :director => 'Truffaut', :tags => ['threesome', 'bicycle', 'french']
#   Film.create! :title => 'Shoot The Pianist', :director => 'Truffaut', :tags => ['piano', 'gangster', 'french']
#   Film.create! :title => 'The Sound of Music', :tags => ['musical', 'ww2']                    
# 
# Use the tagged_with method to find records matching tags
#   Film.tagged_with('musical')
#     => [<The Umbrellas Of Cherbourg>, <The Sound Of Music>]
#   Film.tagged_with('french', 'musical')
#     => [<The Umbrellas Of Cherbourg>]
# 
# As tagged_with is just a scope, you can chain it with standard finders or calculations
#   Film.tagged_with('french').all(:order => 'title')
#     => [<Jules Et Jim>, <Shoot The Pianist>, <The Umbrellas Of Cherbourg>]
#   Film.tagged_with('musicl').all(:conditions => "name like '%Music%'")
#     => [<The Sound Of Music>]
#   Film.tagged_with('french').count
#     => 3
#     
# To find all tags on a model use #tags
#   Film.tags 
#     => ['umbrellas', 'french', 'musical', 'threesome', 'bicycle', 'piano', 'gangster', 'ww2']
#     
# The #tags method also plays nicely with scopes
#   Film.all(:conditions => {'director' => 'Truffaut'}).tags
#     => ['french', 'threesome', 'bicycle', 'piano', 'gangster']
#   Film.tagged_with('french').tags
#     => ['musical', 'french', 'threesome', 'bicycle', 'piano', 'gangster']
# 

module Spraypaint
  module Version
    MAJOR = 1
    MINOR = 0
    PATCH = 1
    STRING = "#{MAJOR}.#{MINOR}.#{PATCH}"
  end
  
  def self.activate_plugin
    ActiveRecord::Base.extend(ClassMethods)
  end
  
  module ClassMethods
    def tag_with_spraypaint(options = {})
      include Spraypaint::Behaviour
    end
  end
end