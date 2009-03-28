Book.tag_with_spraypaint 

a = Book.create!(:title => 'tom', :tags => ['a', 'b', 'c'])
b = Book.create!(:title => 'tom', :tags => {tomafro => ['a', 'b', 'c']})

# All tags, whomever they might be from

a.tags = ['a', 'b', 'c']

a.tags_by[tomafro]

a.find :include => [:this, :that, {:tags_by => tomafro}]
a.tagged_with 'a'
a.tagged_with 'a', :by => tomafro

tags name:string
taggings tag_id:integer, target_id:integer, target_type:string, owner_id:integer, owner_type:string
direct_taggings tag_id:integer, target_id:integer, target_type:string
tagging_counts tag_id:integer, owner_id:integer, owner_type:string, count:integer

tagging is created nand has owner

# First version

Book.tag_with_spraypaint

a = Book.create!(:title => 'tom', :tags => ['a', 'b', 'c'])
a.tags

=> ['a', 'b', 'c']

Book.tags => ['a', 'b', 'c']

Book.written_by(dickens).tags

2.0
===

Model#tags
model.tags
model.tags = 

2.1
===

Model#tags_by[tomafro]

2.2
===

Machine tags