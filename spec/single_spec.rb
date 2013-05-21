require 'spec_helper'

describe "single" do
  it "raises error on nil value (nil.first also raises error)" do
    a = nil
    lambda { a.single } . should raise_error NoMethodError
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
    lambda { a.single } . should raise_exception RuntimeError
  end
end
