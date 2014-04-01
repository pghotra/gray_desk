describe LabelsController do
  render_views

  describe "index" do
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

    describe "new" do
      it "should render form for new label" do
        get :new

        response.body.should have_selector("form#new_label") do |form|
          form.should have_selector(:input, id: 'label_name')
          form.should have_selector(:input, id: 'label_types_')
          form.should have_selector(:input, id: 'label_color')
          form.should have_selector(:input, id: 'label_description')

          form.should_not have_selector(:input, id: 'label_position')
          form.should_not have_selector(:input, id: 'label_enabled')
        end
      end
    end

    describe "create" do
      let(:label_params) { {"name" => "MyLabel", "color" => "gray"} }

      def post_label(attrs={})
        post :create,
             label: label_params.merge(attrs)
      end

      it "passes label params to Label.create" do
        Label.should_receive(:create)
             .with(label_params)
             .and_return(label_params.merge("position" => "32932"))

       post_label
      end

      it "adds success message to flash notice" do
        Label.should_receive(:create)
             .with(label_params)
             .and_return(label_params.merge("position" => "32932"))

       post_label

       flash[:notice].should == "Label MyLabel created successfully"
      end

      it "adds error message to flash notice" do
        invalid_attrs = {"name" => "", "color" => "gray"}
        Label.should_receive(:create).with(invalid_attrs).and_return({})

        post_label(invalid_attrs)

        flash[:error].should == "Unable to create label"
        response.should redirect_to action: :new
      end
    end
  end
end
