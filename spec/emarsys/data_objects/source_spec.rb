require 'spec_helper'

describe Emarsys::Source do
  describe ".collection" do
    it "requests all sources" do
      expect(
        stub_get("source") { Emarsys::Source.collection }
      ).to have_been_requested.once
    end
  end

  describe ".create" do
    it "requests source creation with parameters" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/source/create").with(:body => {:name => 'test_source'}.to_json).to_return(standard_return_body)
      Emarsys::Source.create('test_source')
      expect(stub).to have_been_requested.once
    end
  end

  describe ".delete" do
    it "requests source deletion" do
      stub = stub_request(:delete, "https://api.emarsys.net/api/v2/source/123").to_return(standard_return_body)
      Emarsys::Source.destroy(123)
      expect(stub).to have_been_requested.once
    end
  end
end
