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
      lambda{ a.single }.should raise_error(
        RubyPeterV::UniquenessError,
        "size of collection was 2.")
    end
  end

  describe "accepts a block and uses it for a select" do
    it "block all true" do
      a = [:a, :b]
      lambda{ a.single{ true } }.should raise_error(RubyPeterV::UniquenessError)
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

  describe "works with a lazy Enumerator" do
    let(:large_collection) do
      Object.new.tap do |_a|
        _a.extend Enumerable
        _a.instance_eval do
          def each
            (1..3).each do |i|
              test i
              yield i
            end
          end

          def test(i)
          end
        end
      end
    end

    it "does not have a size method" do
      lambda{ large_collection.size }.should raise_error(NoMethodError)
    end

    it "count reports 3" do
      large_collection.count.should == 3
    end

    describe "single" do
      it "reports the UniquenessError" do
        lambda{ large_collection.single }.should raise_error(
          RubyPeterV::UniquenessError,
          "size of collection was greater than 1 (on Enumerable, the size cannot be calculated).")
      end

      it "does not loop over _all_ elements!" do
        # only needs first and second element to know it is over size
        large_collection.should_receive(:test).with(1)
        large_collection.should_receive(:test).with(2)
        large_collection.should_receive(:test).with(3).exactly(0).times
        begin
          large_collection.single
        rescue RubyPeterV::UniquenessError
        end
      end
    end

    let(:single_collection) do
      Object.new.tap do |_a|
        _a.extend Enumerable
        _a.instance_eval do
          def each
            yield :a
          end
        end
      end
    end

    it "count reports 1" do
      single_collection.count.should == 1
    end

    it "single returns the single value" do
      single_collection.single.should == :a
    end
  end
end
