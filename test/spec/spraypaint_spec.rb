require File.dirname(__FILE__) + '/spec_helper.rb'

describe Spraypaint::Behaviour do
  before(:each) do
    build_model :books do
      string :name
      string :type
      
      tag_with_spraypaint
    end
    
    build_model :non_fiction_books, :superclass => Book
    build_model :novel, :superclass => Book
    
    build_model :films do
      string :name
      string :director
      
      tag_with_spraypaint
    end
  end

  describe "(records initialized with no tags)" do
    before(:each) do
      @it = Film.new :name => 'No Country For Old Men'
    end
    
    it "should return an empty array for tags" do
      @it.tags.should == []
    end
    
    it "should return false for tags_changed?" do
      @it.tags_changed?.should be_false
    end
  end
  
  describe "(records initialized with tags passed into constructor)" do
    before(:each) do
      @tags = ['some', 'tags', 'to', 'set']
      @it = Film.new(:tags => @tags)
    end
    
    it "should return tags passed to constructor" do
      @it.tags.should == @tags
    end
    
    it "should return true for tags_changed?" do
      @it.tags_changed?.should be_true
    end
  end
  
  describe "(records with no tags)" do
    before(:each) do
      @it = Film.new :name => 'No Country For Old Men'
    end
    
    it "should save successfully" do
      @it.save
      @it.id.should_not be_nil
    end
    
    it "should return an empty array of tags after reloading" do
      @it.save!
      @it = @it.class.find(@it.id)
      @it.tags.should == []
    end
  end
  
  describe "(records with tags)" do
    before(:each) do
      @tags = ['mccarthy', 'coen brothers']
      @it = Film.new :name => 'No Country For Old Men', :tags => @tags
    end

    it "should save successfully" do
      @it.save
      @it.id.should_not be_nil
    end

    it "should return original tags after reloading" do
      @it.save!
      @it = @it.class.find(@it.id)
      @it.tags.should == @tags
    end
    
    it "should retain tag order after saving and reloading" do
      Film.create! :name => 'Dummy Film', :tags => ['a', 'b', 'c', 'd']
      @it.tags = ['z', 'a', 'd', 'b']
      @it.save!
      @it = @it.class.find(@it.id)
      @it.tags.should == ['z', 'a', 'd', 'b']
    end
  end
  
  describe "(setting tags using #tags=)" do
    before(:each) do
      @tags = ['some', 'tags', 'to', 'set']
      @it = Film.new
    end
      
    it "should set tags to empty array if set to nil" do
      @it.tags = @tags
      @it.tags = nil
      @it.tags.should == []
    end
    
    it "should remove duplicate tags" do
      @it.tags = ['duplicate', 'duplicate', 'original']
      @it.tags.should == ['duplicate', 'original']
    end
    
    it "should remove nil tags" do
      @it.tags = [nil, 'by', 'mouth']
      @it.tags.should == ['by', 'mouth']
    end
    
    it "should remove zero-length tags" do
      @it.tags = ['', 'clean', '']
      @it.tags.should == ['clean']
    end
    
    it "should sanitize tags" do
      @it.class.tag_sanitizer.should_receive(:sanitize_tag).with('unsanitized').and_return('sanitized')
      @it.tags = ['unsanitized']
      @it.tags.should == ['sanitized']
    end
    
    it "should remove duplicates that result from sanitization" do
      @it.class.tag_sanitizer.stub!(:sanitize_tag).and_return('clean')
      @it.tags = ['unclean', 'dirty', 'filthy']
      @it.tags.should == ['clean']
    end
    
    it "should remove zero-length tags that result from sanitization" do
      @it.class.tag_sanitizer.stub!(:sanitize_tag).and_return(nil)
      @it.tags = ['unclean', 'dirty', 'filthy']
      @it.tags.should == []
    end
    
    it "should remove nil tags that result from sanitization" do
      @it.class.tag_sanitizer.stub!(:sanitize_tag).and_return(nil)
      @it.tags = ['unclean', 'dirty', 'filthy']
      @it.tags.should == []
    end
  end
  
  describe "(setting tags using #tag_string=)" do
    before(:each) do
      @it = Film.new :name => 'Film 5'
    end
    
    it "should split string up by commas" do
      @it.tag_string = "some, tags, go, here"
      @it.tags.should == ['some', 'tags', 'go', 'here']
    end
  
    it "should remove superfluous whitespace surrounding tags" do
      @it.tag_string = "some   , tags, go  ,  here"
      @it.tags.should == ['some', 'tags', 'go', 'here']  
    end
  
    it "should set tags to empty array if set to nil" do
      @it.tag_string = nil
      @it.tags.should == []
    end
  end
  
  describe "(reading tag_string on records with a tag_string db column)" do  
    before(:each) do
      @it = Film.new :name => 'Film 5'
    end
    
    it "should read tag_string direct from db" do
      @it.tag_string = "some   , tags, go  ,  here"
      @it.save!
      @it = Film.find(@it.id)
      @it.tag_string = "some   , tags, go  ,  here"
    end
  end
  
  
  describe "(reading tag_string on records where there is no tag_string db column)" do  
    before(:each) do
      @it = Book.new :name => 'Book 5'
    end
    
    it "should reconstitue tag string from tags" do
      @it.tag_string = "some   , tags, go  ,  here"
      @it.save!
      @it = Book.find(@it.id)
      @it.tag_string = "some, tags, go, here"
    end
  end
  
  describe "(finding tags associated with a class of records)" do
    before(:each) do
    end
    
    it "should return set of tags associated with individual records" do
      Film.create! :name => 'No Country For Old Men', :tags => ['coen brothers', 'josh brolin']
      Film.create! :name => 'W', :tags => ['oliver stone', 'josh brolin']
      Film.tags.sort.should == ['coen brothers', 'josh brolin', 'oliver stone']
    end
    
    it "should limit found tags by class of record" do
      Film.create! :name => 'No Country For Old Men', :tags => ['coen brothers', 'mccarthy']
      Book.create! :name => 'No Country For Old Men', :tags => ['mccarthy', 'novel']
      Film.tags.should == ['coen brothers', 'mccarthy']
    end
    
    it "should limit tags found using STI subclasses" do
      NonFictionBook.create! :name => 'The Wealth Of Nations', :tags => ['economics', 'adam smith']
      Novel.create! :name => 'The Road', :tags => ['post apocalyptic', 'mccarthy']
      Book.tags.should == ['adam smith', 'economics', 'mccarthy', 'post apocalyptic']
      Novel.tags.should == ['mccarthy', 'post apocalyptic']
    end
    
    it "should respect scoped queries" do
      Film.named_scope 'directed_by', lambda {|director|
        {:conditions => {:director => director}}
      }
      
      Film.create! :name => 'Goodfellas', :director => 'Scorcese', :tags => ['mafia', 'gangster']
      Film.create! :name => 'The Great Dictator', :director => 'Chaplin', :tags => ['hitler', 'satire']
      Film.create! :name => 'Raging Bull', :director => 'Scorcese', :tags => ['boxing']
      
      Film.directed_by('Scorcese').tags.sort.should == ['boxing', 'gangster', 'mafia']
      Film.directed_by('Chaplin').tags.sort.should == ['hitler', 'satire']
    end
    
    it "should return tags in decending order of frequency" do
      Film.create! :name => 'Superman', :tags => ['first']
      Film.create! :name => 'Superman 2', :tags => ['second']
      Film.create! :name => 'Police Academy 2', :tags => ['second']
      Film.create! :name => 'Rocky 3', :tags => ['third']
      Film.create! :name => 'Naked Gun 33 1/3', :tags => ['third']
      Film.create! :name => 'Spiderman 3', :tags => ['third']
      
      Film.tags.should == ['third', 'second', 'first']
    end
    
    it "should return tags alphabetically if frequency is the same" do
      Film.create! :name => 'No Country For Old Men', :tags => ['coen brothers']
      Film.create! :name => 'W', :tags => ['oliver stone']
      Film.create! :name => 'The Great Dictator', :tags => ['charlie chaplin']
      Film.tags.should == ['charlie chaplin', 'coen brothers', 'oliver stone']
      
    end
    
    it "should respect limit and offset on the returned tags" do
      Film.create! :name => 'No Country For Old Men', :tags => ['coen brothers', 'josh brolin']
      Film.create! :name => 'W', :tags => ['oliver stone', 'josh brolin']
      Film.tags(:limit => 1).should == ['josh brolin']
      Film.tags(:limit => 1, :offset => 1).should == ['coen brothers']
    end
    
    it "should include the frequency as an attribute on returned tags" do
      Film.create! :name => 'No Country For Old Men', :tags => ['coen brothers', 'josh brolin']
      Film.create! :name => 'W', :tags => ['oliver stone', 'josh brolin']
      Film.tags.first.frequency.should == 2
    end
  end
  
  describe "(finding records via their tags)" do
    it "should return records matching given tag" do
      no_country = Film.create! :name => 'No Country For Old Men', :tags => ['coen brothers', 'josh brolin']
      w = Film.create! :name => 'W', :tags => ['oliver stone', 'josh brolin']
      Film.tagged_with('oliver stone').should == [w]
    end
    
    it "should return records matching all given tags" do
      no_country = Film.create! :name => 'No Country For Old Men', :tags => ['coen brothers', 'josh brolin']
      w = Film.create! :name => 'W', :tags => ['oliver stone', 'josh brolin']
      Film.tagged_with('oliver stone', 'josh brolin').should == [w]
      Film.tagged_with('oliver stone', 'coen brothers').should == []
    end
    
    it "should sanitize tags before searching" do
      Film.tag_sanitizer.stub!(:sanitize_tag).and_return('clean')
      Film.create! :name => 'No Country For Old Men', :tags => ['unclean']
      Film.tagged_with('dirty').size.should == 1
    end
  end
end