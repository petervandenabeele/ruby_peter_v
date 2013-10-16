require 'spec_helper'

describe "set_once" do

  let(:subject) { Object.new }

  it 'raises ArgumentError when the attribute argument is not a symbol' do
    lambda { subject.set_once(nil, 10) } . should raise_error(
      ArgumentError,
      'first argument must be a symbol for the attribute')
  end

  it "can be set when nil" do
    subject.instance_variable_get(:@attr).should be_nil # assert pre-condition
    value = 10
    subject.set_once(:attr, value)
    subject.instance_variable_get(:@attr).should == value
  end

  describe "setting it two times" do
    it "with the same value just works" do
      value = 10
      subject.set_once(:attr, value)
      subject.set_once(:attr, value)
      subject.instance_variable_get(:@attr).should == value
    end

    it "with a different value raises a SetOnceError" do
      value = 10
      subject.set_once(:attr, value)
      lambda { subject.set_once(:attr, value+1) } . should raise_error(
        RubyPeterV::SetOnceError,
        "Value of attr was 10, trying to set it to 11")
    end
  end
end
