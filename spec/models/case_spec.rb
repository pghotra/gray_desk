describe Case do
  let(:mock_cases) do
    ActiveSupport::JSON.encode [{"id" => 1, "status" => "open"}]
  end

  let(:empty_response) do
    ActiveSupport::JSON.encode []
  end

  describe ".all" do
    it "should return all cases" do
      OAuth::AccessToken.stub_chain(:from_hash, :get, :body).and_return(mock_cases)

      Case.all.should == ActiveSupport::JSON.decode(mock_cases)
    end

    it "returns empty array when no cases available" do
      OAuth::AccessToken.stub_chain(:from_hash, :get, :body).and_return(empty_response)

      Case.all.should == []
    end
  end
end
