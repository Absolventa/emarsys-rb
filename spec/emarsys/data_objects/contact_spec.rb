require 'spec_helper'

describe Emarsys::Contact do
  describe ".create" do
    it "requests contact creation" do
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/contact").to_return(standard_return_body)
      Emarsys::Contact.create
      stub.should have_been_requested.once
    end

    it "requests contact creation with parameters" do
      stub_params = {1 => 'John', 2 => "Doe", 3 => "john.doe@example.com"}
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/contact").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Contact.create(stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".update" do
    it "requests contact update with parameters" do
      stub_params = {1 => 'Jane', 2 => "Doe", 3 => "jane.doe@example.com"}
      stub = stub_request(:put, "https://suite5.emarsys.net/api/v2/contact").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Contact.update(stub_params)
      stub.should have_been_requested.once
    end
  end
end