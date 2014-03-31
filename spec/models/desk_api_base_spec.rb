describe DeskApiBase do
  let(:entries) do
    [{"id" => 1, "status" => "open"},
     {"id" => 2, "status" => "escalated"}]
  end

  let(:response_body) do
    ActiveSupport::JSON.encode({ "_embedded" => {"entries" => entries}})
  end

  let(:access_token) do
    double(get: double(body: response_body))
  end

  describe ".get" do
    describe " when valid" do
      before(:each) do
        DeskApiBase.should_receive(:access_token).and_return(access_token)
        access_token.should_receive(:get)
                   .with([DeskApiBase::HOST, "foo/bar"].join("/"))
      end

      it "fetches data for the given endpoint" do
        DeskApiBase.get("foo/bar", CaseParser)
      end

      it "passes a json for response to parser" do
        CaseParser.should_receive(:from_json).and_return(anything)

        DeskApiBase.get("foo/bar", CaseParser)
      end
    end

    describe "when invalid" do
      it "raises BadApiEndpoint" do
        expect { DeskApiBase.get(nil, CaseParser) }.to raise_error DeskApiBase::BadApiEndpoint
      end
    end
  end
end
