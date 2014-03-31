describe Label do
  describe ".all" do
    it "calls api base get with correct arguments" do
      Label.should_receive(:get).with("api/v2/labels", EmbeddedEntriesParser)

      Label.all
    end
  end
end
