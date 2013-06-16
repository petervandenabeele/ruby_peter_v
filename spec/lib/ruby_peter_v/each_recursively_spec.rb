require 'spec_helper'

describe "each_recursively" do

  let(:a) { Object.new }

  it "does it once for a non collection object" do
    a.should_receive(:test_it).exactly(1).times
    a.each_recursively do |_e|
      _e.test_it
    end
  end

  it "does it for each entry in a simple array" do
    a.should_receive(:test_it).exactly(2).times
    [a,a].each_recursively do |_e|
      _e.test_it
    end
  end

  it "does it for each entry in a complex combination" do
    a.should_receive(:test_it).exactly(6).times
    [a,[a,a],[[[a],a],a]].each_recursively do |_e|
      _e.test_it
    end
  end

  # This feature allows streaming
  describe "works on an enumerable that is NOT an array" do
    let(:b) do
      _b = Object.new
      _b.extend Enumerable
      _b.instance_eval do
        def each
          yield "test"
          yield "test"
        end
      end
      _b
    end

    it "call the each block 2 times" do
      a.should_receive(:test_it).with("test").exactly(2).times
      b.each_recursively do |_e|
        a.test_it(_e)
      end
    end

    it "returns self" do
      a.stub(:test_it)
      b.each_recursively do |_e|
        a.test_it(_e)
      end.should == b
    end

    it "works with lazy in Ruby 2.0" do
      pending("only Ruby >= 2.0") unless RUBY_VERSION.split('.').first.to_i >= 2
      a.should_receive(:test_it).with("test").exactly(2).times
      b.lazy.each_recursively do |_e|
        a.test_it(_e)
      end
    end

    it "does not call to_a on the collection" do
      b.instance_eval do
        def to_a
          raise "Should not call to_a (no instantiation of the stream)"
        end
      end

      b.each_recursively do |_e|
        _e
      end
    end
  end
end
