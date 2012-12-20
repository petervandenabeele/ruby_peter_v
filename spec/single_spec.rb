require 'spec_helper'

describe "single" do
  it "keeps a nil value" do
    a = nil
    a.single.should == nil
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
    lambda{a.single}.should raise_exception
  end
end
