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

  describe ".find_by_id" do
    it "returns a case object" do
      Case.should_receive(:get)
          .with("api/v2/cases/32", SingularResourceParser)
          .and_return({"subject" => "a test case", "status"=>"open",
                        "type" => "email", "priority" => 9, "id" => 32})

      case_item = Case.find_by_id(32)

      case_item.should be_kind_of Case
      case_item.id.should == 32
    end
  end

  describe ".update" do
    it "returns updated case object" do
      original_attrs = {"subject" => 'Fix-it-all',
                           "labels" => ["foo"],
                           'status' => 'open',
                           'type' => 'twitter',
                           'id' => 1}

      attrs = {"labels" => ["macro"], "label_action" => "replace"}

      Case.should_receive(:put)
          .with("api/v2/cases/1", attrs)
          .and_return(original_attrs.merge("labels" => ["macro"]))

      updated_case = Case.update(1, attrs)

      updated_case.should be_kind_of Case
      updated_case.labels.should == ["macro"]
      updated_case.id.should == 1
    end
  end
end
