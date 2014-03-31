describe LabelsController do
  describe "index" do
    render_views

    let(:mock_labels) do
      [{"name" => "Abandoned Chats", "enabled" => "true", "color" => "default"},
       {"name" => "More Info", "enabled" => "true", "color" => "default"}]
    end

    describe "when labels are present" do
      before(:each) do
        Label.should_receive(:all).and_return(mock_labels)
      end

      it "renders table headers" do
        get :index

        response.body.should have_selector("#labelsTable .table-header") do |header|
          header.should have_selector(:span, content: "Name")
          header.should have_selector(:span, content: "Enabled")
          header.should have_selector(:span, content: "Color")
        end
      end

      it "renders a list of labels" do
        get :index

        response.body.should have_selector("#labelsTable .table-content") do |labels|
          labels.should have_selector("span", content: 'Abandoned Chats')
          labels.should have_selector("span", content: 'More Info')
        end
      end
    end

    describe "when no label present" do
      it "renders no labels available" do
        Label.should_receive(:all).and_return([])

        get :index

        response.body.should have_selector("#labelsTable:contains('No Labels Available')")
      end
    end
  end
end
