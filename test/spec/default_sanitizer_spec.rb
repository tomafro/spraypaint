require File.dirname(__FILE__) + '/spec_helper.rb'

describe Spraypaint::DefaultSanitizer do
  describe '(with no arguments passed to constructor)' do
    before(:each) do
      @it = Spraypaint::DefaultSanitizer.new
    end
    
    it "should strip surrounding whitespace from tag" do
      @it.sanitize("    hello     ").should == "hello"
    end

    it "should convert accented characters to their non-accented forms" do
      @it.sanitize("fåçêtîous").should == "facetious"
    end
    
    it "should remove all non-allowed characters" do
      @it.sanitize("a*b^c@d!e%f$g").should == "abcdefg"
    end

    it "should leave passed in tag unaltered" do
      @it.sanitize(value = "    hello     ")
      value.should == "    hello     "
    end
  end
end