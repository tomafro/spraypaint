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
end