describe ActiveModelImpersnation do
  class ExampleClass
    attr_accessor :id

    include ActiveModelImpersnation
  end

  class BadHost
    include ActiveModelImpersnation
  end

  describe ".persisted?" do
    it "is true when model has valid id" do
      objekt = ExampleClass.new
      objekt.id = "foo"

      objekt.persisted?.should == true
    end

    it "is false when model does not have valid id" do
      objekt = ExampleClass.new
      objekt.id = nil

      objekt.persisted?.should == false
    end

    it "raises exception when model doesn't respond_to :id" do
      expect -> do
        BadHost.new.persisted?
      end.should raise_error "including class must define id"
    end
  end
end
