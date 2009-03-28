require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Spraypaint::Model::Tag do
  before(:each) do
    @class = Spraypaint::Model::Tag
    @it = Spraypaint::Model::Tag.new
  end
  
  describe "(in general)" do
    it "should be valid with a name" do
      @it.name = 'name'
      @it.should be_valid
    end
    
    it "should not be valid without a name" do
      @it.name = nil
      @it.should_not be_valid
    end
  end
    # 
    # describe '#sanitize' do
    #   before(:each) do
    #     @characters = Spraypaint.allowed_tag_characters
    #   end
    #   
    #   after(:each) do
    #     Spraypaint.allowed_tag_characters = @characters
    #   end
    #   
    #   it "should strip surrounding whitespace from tag" do
    #     @class.sanitize("    hello     ").should == "hello"
    #   end
    # 
    #   it "should convert accented characters to their non-accented forms" do
    #     @class.sanitize("fåçêtîous").should == "facetious"
    #   end
    # 
    #   it "should remove all non-allowed characters" do
    #     Spraypaint.allowed_tag_characters = /[acef]/ 
    #     @class.sanitize("abcdefedcba").should == "acefeca"
    #     Spraypaint.allowed_tag_characters = /[db]/ 
    #     @class.sanitize("abcdefedcba").should == "bddb"
    #   end
    # 
    #   it "should leave passed in tag unaltered" do
    #     @class.sanitize(value = "    hello     ")
    #     value.should == "    hello     "
    #   end
    # end
end