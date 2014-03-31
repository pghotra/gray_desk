describe CasesController do
  describe :index do
    render_views

    describe "when cases available" do

      it "should render entries case table" do
        get :index

        response.body.should have_selector("#caseTable") do |cases|
          cases.should have_selector("div.case", text: 'Fix it All')
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
