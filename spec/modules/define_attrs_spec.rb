describe DefineAttrs do
  class FooBar
    extend DefineAttrs

    define_accessors([:foo, :bar, :baz])
  end

  describe "define_attrs" do
    it "adds attr_readers and attr_writers to self" do
      FooBar.new.should respond_to(:foo)
      FooBar.new.should respond_to(:bar)
      FooBar.new.should respond_to(:baz)

      FooBar.new.should respond_to(:foo=)
      FooBar.new.should respond_to(:bar=)
      FooBar.new.should respond_to(:baz=)
    end

    it "adds instance variable to hold specified attrs" do
      FooBar.new.attributes.should == [:foo, :bar, :baz]
    end
  end
end
