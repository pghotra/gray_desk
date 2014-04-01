describe DeskApiBase do
  let(:entries) do
    [{"id" => 1, "status" => "open"},
     {"id" => 2, "status" => "escalated"}]
  end

  let(:post_request_body) do
    {"name" =>"MyLabel", "description" => "A Test Label",
     "types" => ["case"], "color" => "gray"}
  end

  let(:access_token) do
    get_response_body = ActiveSupport::JSON.encode({ "_embedded" => {"entries" => entries}})
    post_response_body = ActiveSupport::JSON.encode(post_request_body.merge("position" => 1))

    double(get: double(body: get_response_body),
           post: double(body: post_response_body))
  end

  describe ".get" do
    describe " when valid" do
      before(:each) do
        DeskApiBase.should_receive(:access_token).and_return(access_token)
        access_token.should_receive(:get)
                   .with([DeskApiBase::HOST, "foo/bar"].join("/"))
      end

      it "fetches data for the given endpoint" do
        DeskApiBase.get("foo/bar", EmbeddedEntriesParser)
      end

      it "passes a json for response to parser" do
        EmbeddedEntriesParser.should_receive(:from_json).and_return(anything)

        DeskApiBase.get("foo/bar", EmbeddedEntriesParser)
      end
    end

    describe "when invalid" do
      it "raises BadApiEndpoint" do
        expect { DeskApiBase.get(nil, EmbeddedEntriesParser) }.to raise_error DeskApiBase::BadApiEndpoint
      end
    end
  end

  describe ".post" do
    let(:headers) do
      {'Accept' => 'application/json',
       'Content-Type' => 'application/json'}
    end

    describe "when valid" do
      before(:each) do
        DeskApiBase.should_receive(:access_token).and_return(access_token)
      end

      it "returns created resource" do
        access_token.should_receive(:post)
                    .with([DeskApiBase::HOST, "foo/bar"].join("/"),
                          ActiveSupport::JSON.encode(post_request_body),
                          headers)

        DeskApiBase.post("foo/bar", post_request_body)
                   .should == post_request_body.merge("position" => 1)
      end

      it "posts request with correct headers" do
        access_token.should_receive(:post)
                    .with([DeskApiBase::HOST, "foo/bar"].join("/"),
                          "{}",
                          headers)

        DeskApiBase.post("foo/bar", {})
      end

      it "posts request with correct body" do
        access_token.should_receive(:post)
                    .with([DeskApiBase::HOST, "foo/bar"].join("/"),
                          ActiveSupport::JSON.encode(post_request_body),
                          headers)

        DeskApiBase.post("foo/bar", post_request_body)
      end
    end

    describe "when invalid request" do
      it "returns response indicating error condition" do
      end
    end
  end
end
