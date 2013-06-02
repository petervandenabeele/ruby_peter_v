require 'spec_helper'

describe "define_equality" do
  describe "without defining eql on the instance var" do

    let(:a) { Object.new }

    it "objects are eql? and == and same hash when they are actually the same in memory" do
      a.should be_eql(a)
      a.should ==  a
      a.hash.should ==  a.hash
    end

    it "objects are not (eql? and == and same hash) when they are not the same in memory" do
      a.should_not be_eql(Object.new)
      a.should_not ==  Object.new
      a.hash.should_not ==  Object.new.hash
    end
  end

  describe "with define_equality" do

    let(:a1) do
      Object.new.tap do |_o|
        _o.instance_eval do
          @foo = '1'
          @bar = '1'
          self.singleton_class.class_eval { include DefineEquality() }
        end
      end
    end

    let(:a2) do
      Object.new.tap do |_o|
        _o.instance_eval do
          @foo = '1'
          @bar = '2'
          self.singleton_class.class_eval { include DefineEquality() }
        end
      end
    end

    let(:b1) do
      Object.new.tap do |_o|
        _o.instance_eval do
          @foo = '1'
          @bar = '1'
          def foo ; @foo ; end
          self.singleton_class.class_eval { include DefineEquality(:foo) }
        end
      end
    end

    let(:b2) do
      Object.new.tap do |_o|
        _o.instance_eval do
          @foo = '1'
          @bar = '2'
          def foo ; @foo ; end
          self.singleton_class.class_eval { include DefineEquality(:foo) }
        end
      end
    end

    let(:b3) do
      Object.new.tap do |_o|
        _o.instance_eval do
          @foo = '2'
          @bar = '1'
          def foo ; @foo ; end
          self.singleton_class.class_eval { include DefineEquality(:foo) }
        end
      end
    end

    it "objects are eql? and == and same hash when they are actually the same in memory" do
      a1.should be_eql(a1)
      a1.should == a1
      a1.hash.should == a1.hash
    end

    # the instance_eval only affects the singleton_class of the test object
    it "should not leak into general Object" do
      a1.should be_eql(a2)
      o1 = Object.new
      o2 = Object.new
      o1.should_not be_eql(o2)
      o1.should_not == o2
      o1.hash.should_not == o2.hash
    end

    describe "objects are eql? and == and same hash when" do
      describe "they have same class and" do
        it "no instance vars in define_equality" do
          a1.should be_eql(a2)
          a1.should == a2
          a1.hash.should == a2.hash
        end

        it "equal instance vars in define_equality" do
          b1.should be_eql(b2)
          b1.should == b2
          b1.hash.should == b2.hash
        end
      end
    end

    describe "objects are not (eql? and == and same hash) when" do
      it "they are different class" do
        a1.should_not be_eql('')
        a1.should_not == ''
        a1.hash.should_not == ''.hash
      end

      it "they are same class and different instance var value" do
        b1.should_not be_eql(b3)
        b1.should_not == b3
        b1.hash.should_not == b3.hash
      end
    end
  end
end
