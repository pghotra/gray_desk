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
  end
  describe "persisted?" do
    it "is true when position does not exist" do
      Label.new.persisted?.should == false
    end

    it "is false when position exists" do
      label = Label.new
      label.position = "foo"

      label.persisted?.should == true
    end
  end
end
