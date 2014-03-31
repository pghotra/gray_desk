describe Case do
  describe ".all" do
    it "calls api base get with correct arguments" do
      Case.should_receive(:get).with("api/v2/cases", CaseParser)

      Case.all
    end
  end
end
