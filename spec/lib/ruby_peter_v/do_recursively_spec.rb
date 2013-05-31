require 'spec_helper'

describe "do_recursively" do

  let(:a) {Object.new}

  it "does it once for a non collection object" do
    a.should_receive(:test_it).exactly(1).times
    do_recursively(a) do |_e|
      _e.test_it
    end
  end

  it "does it for each entry in a simple array" do
    a.should_receive(:test_it).exactly(2).times
    do_recursively([a,a]) do |_e|
      _e.test_it
    end
  end

  it "does it for each entry in a complex combination" do
    a.should_receive(:test_it).exactly(6).times
    do_recursively([a,[a,a],[[[a],a],a]]) do |_e|
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
      do_recursively(b) do |_e|
        a.test_it(_e)
      end
    end

    it "works with lazy in Ruby 2.0" do
      pending("only Ruby >= 2.0") unless RUBY_VERSION.split('.').first.to_i >= 2
      a.should_receive(:test_it).with("test").exactly(2).times
      do_recursively(b.lazy) do |_e|
        a.test_it(_e)
      end
    end

    it "does not call to_a on the collection" do
      b.instance_eval do
        def to_a
          raise "Should not call to_a (no instantiation of the stream)"
        end
      end

      do_recursively(b) do |_e|
        _e
      end
    end
  end

end
