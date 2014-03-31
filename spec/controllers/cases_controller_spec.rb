describe CasesController do
  describe :index do
    render_views

    describe "when cases available" do
      let(:mock_cases) do
        [{"subject" => 'Fix-it-all', 'status' => 'open', 'type' => 'twitter'},
         {"subject" => 'Test Case', 'status' => 'open', 'type' => 'email'}]
      end

      before(:each) do
        Case.should_receive(:all).and_return(mock_cases)
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
end
