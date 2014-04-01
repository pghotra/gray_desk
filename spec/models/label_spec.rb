describe Label do
  describe ".all" do
    it "calls api base get with correct arguments" do
      Label.should_receive(:get).with("api/v2/labels", EmbeddedEntriesParser)

      Label.all
    end
  end

  describe "create" do
    it "calls api base post with specified attributes" do
      attrs = {"name" => "ProveIt"}
      Label.should_receive(:post).with("api/v2/labels", attrs).and_return({})

      Label.create(attrs)
    end

    it "returns a Label object" do
      attrs = {"name"=>"ProveIt 3", "description"=>"Gray Label 3",
               "enabled"=>true, "types"=>["macro"], "color"=>"grey"}

      Label.should_receive(:post)
          .with("api/v2/labels",attrs)
          .and_return(attrs.merge({"id" => 32, "_links" => {"self" => "/label/32"}}))

     label = Label.create(attrs)

     label.should be_kind_of(Label)
     label.id.should == 32
    end
  end
  describe "persisted?" do
    it "is true when id does not exist" do
      Label.new.persisted?.should == false
    end

    it "is false when id exists" do
      label = Label.new
      label.id = "foo"

      label.persisted?.should == true
    end
  end
end
