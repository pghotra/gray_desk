describe Case do
  describe ".all" do
    it "calls api base get with correct arguments" do
      Case.should_receive(:get).with("api/v2/cases", EmbeddedEntriesParser)

      Case.all
    end

    it "returns a collection of case objects" do
      case_response = [{"subject" => "a test case", "status"=>"open",
                        "type" => "email", "priority" => 9, "id" => 32},
                       {"subject" => "another test case", "status"=>"open",
                        "type" => "twitter", "priority" => 9, "id" => 77}]

      Case.should_receive(:get)
          .with("api/v2/cases", EmbeddedEntriesParser)
          .and_return(case_response)

     case_items = Case.all

     case_items.should have(2).items
     case_items.first.should be_kind_of(Case)
     case_items.first.id.should == 32
    end
  end
end
