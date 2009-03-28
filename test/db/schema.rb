# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090323171649) do
  create_table 'spraypaint_tags', :force => true do |t|
    t.string 'name', :null => false
  end
  
  create_table 'spraypaint_taggings', :force => true do |t|
    t.integer 'tag_id', :null => false
    t.integer 'target_id', :null => false
    t.string  'target_type', :null => false
    t.integer 'owner_id'
    t.string 'owner_type'
  end
  
  create_table 'books', :force => true do |t|
    t.string 'name', :null => false
    t.string 'author'
    t.string 'type'
  end
  
  create_table 'films', :force => true do |t|
    t.string 'name', :null => false
    t.string 'director'
    t.string 'tag_string'
  end
  
  create_table 'accounts', :force => true do |t|
    t.string 'login', :null => false
  end
end
