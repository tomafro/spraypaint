require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Spraypaint::Model::Tagging do
  before(:each) do
    @class = Spraypaint::Model::Tagging
    @it = Spraypaint::Model::Tagging.new
  end
  
  describe "(in general)" do
    before(:each) do
      build_model :books do
        string :name
      end
      
      @it.tag = Spraypaint::Model::Tag.create :name => 'a'
      @it.target = Book.create :name => 'b'
    end
    
    it "should be valid with a tag and a target" do
      @it.should be_valid
    end
    
    it "should not be valid without a tag" do
      @it.tag = nil
      @it.should_not be_valid
    end
    
    it "should not be valid without a target" do
      @it.target = nil
      @it.should_not be_valid
    end
    
    it "should allow an association with a tag" do
      @tag = Spraypaint::Model::Tag.create! :name => 'tag'
      @it.tag = @tag
      @it.save!
      @reloaded = @class.find(@it.id)
      @reloaded.tag.should == @tag
    end
    
    it "should allow an association with a target" do
      @target = Book.create! :name => 'tag'
      @it.target = @target
      @it.save!
      @reloaded = @class.find(@it.id)
      @reloaded.target.should == @target
    end
  end
end