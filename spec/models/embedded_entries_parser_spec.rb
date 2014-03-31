describe EmbeddedEntriesParser do
  describe ".from_json" do
    let(:entries) do
      [{"id" => 1, "status" => "open"},
       {"id" => 2, "status" => "escalated"}]
    end

    let(:case_json) do
      {
        "_embedded" => {"entries" => entries}
      }
    end

    it "returns a collection of cases" do
      cases = EmbeddedEntriesParser.from_json(case_json)

      cases.should have(2).items
    end

    it "returns empty collection when no case entries given" do
      EmbeddedEntriesParser.from_json({}).should == []
    end

    it "returns attributes for each case" do
      cases = EmbeddedEntriesParser.from_json(case_json)

      cases[0].should == entries.first
      cases[1].should == entries.last
    end
  end
end
