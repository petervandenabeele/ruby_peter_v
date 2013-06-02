require 'spec_helper'

describe "single" do
  describe "without a block" do
    it "raises error on nil value (nil.first also raises error)" do
      a = nil
      lambda{ a.single }.should raise_error NoMethodError
    end

    it "nil for empty set" do
      a = []
      a.single.should == nil
    end

    it "OK for 1 element in set" do
      a = [:a]
      a.single.should == :a
    end

    it "exception for > 1 element in set" do
      a = [:a, :b]
      lambda{ a.single }.should raise_exception RubyPeterV::UniquenessError
    end
  end

  describe "accepts a block and uses it for a select" do
    it "block all true" do
      a = [:a, :b]
      lambda{ a.single{ true } }.should raise_exception RubyPeterV::UniquenessError
    end

    it "block filters on :a" do
      a = [:a, :b]
      a.single{|e| e == :a}.should == :a
    end

    it "nil block" do
      a = [:a, :b]
      a.single{  }.should == nil
    end
  end
end
