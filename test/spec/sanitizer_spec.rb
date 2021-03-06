require File.dirname(__FILE__) + '/spec_helper.rb'

describe Spraypaint::Sanitizer do
  describe '(with no arguments passed to constructor)' do
    before(:each) do
      @it = Spraypaint::Sanitizer.new
    end
    
    it "should strip surrounding whitespace from tag" do
      @it.sanitize_tag("    hello     ").should == "hello"
    end

    it "should convert accented characters to their non-accented forms" do
      @it.sanitize_tag("fåçêtîous").should == "facetious"
    end
    
    it "should remove all non-allowed characters" do
      @it.sanitize_tag("a*b^c@d!e%f$g").should == "abcdefg"
    end

    it "should leave passed in tag unaltered" do
      @it.sanitize_tag(value = "    hello     ")
      value.should == "    hello     "
    end
  end
end