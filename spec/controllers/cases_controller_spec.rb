describe CasesController do
  render_views

  describe :index do
    describe "when cases available" do
      let(:mock_cases) do
        [{"subject" => 'Fix-it-all', 'status' => 'open', 'type' => 'twitter', 'id' => 1, "labels" => ["macro"]},
         {"subject" => 'Test Case', 'status' => 'open', 'type' => 'email', 'id' => 2, "labels" => ["macro"]}]
      end

      before(:each) do
        cases = mock_cases.map { |attrs| Case.new(attrs) }
        Case.should_receive(:all).and_return(cases)
      end

      it "renders table headers" do
        get :index

        response.body.should have_selector("#caseTable .table-header") do |header|
          header.should have_selector(:span, content: "Subject")
          header.should have_selector(:span, content: "Status")
          header.should have_selector(:span, content: "Type")
        end
      end

      it "should render entries case table" do
        get :index

        response.body.should have_selector("#caseTable .table-content") do |cases|
          cases.should have_selector(:span, content: 'Fix-it-all')
          cases.should have_selector(:a, content: 'Edit', href: '/cases/1/edit')
        end
      end
    end

    describe "when no case available" do
      it "should render no case available" do
        Case.should_receive(:all).and_return([])

        get :index

        response.body.should have_selector("#caseTable:contains('No Cases Available')")
      end
    end
  end

  describe "Edit" do
    it "renders the case form" do
      case_item = Case.new({"subject" => 'Fix it all', 'id' => 1, labels: ["macro"]})

      Case.should_receive(:find_by_id).and_return(case_item)

      get :edit,
          id: 1

      response.body.should have_selector("form#edit_case_1 #case_labels[value='macro']")
    end
  end
end
