require 'spec_helper'

describe "max_with_nil" do
  it "nil if a and b are nil" do
    max_with_nil(nil, nil).should == nil
  end

  it "b if a is nil" do
    max_with_nil(nil, 10).should == 10
  end

  it "a if b is nil" do
    max_with_nil(10, nil).should == 10
  end

  it "a if a > b" do
    max_with_nil(10, 5).should == 10
  end

  it "b if b > a" do
    max_with_nil(5, 10).should == 10
  end

  it "a if a == b" do
    a = "test"
    b = "test"
    max_with_nil(a, b).object_id.should == a.object_id
  end
end
