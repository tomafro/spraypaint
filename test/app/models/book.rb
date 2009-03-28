class Book < ActiveRecord::Base
  tag_with_spraypaint
  
  named_scope 'written_by', lambda {|author|
    {:conditions => {:author => author}}
  }
end
