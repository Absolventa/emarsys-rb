require 'spec_helper'

describe Emarsys::Contact do
  describe ".create" do
    it "requests contact creation with parameters" do
      stub_params = {1 => 'John', 2 => "Doe"}
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/contact").with(:body => stub_params.merge!({'key_id' => 3, 3 => 'john.doe@example.com'}).to_json).to_return(standard_return_body)
      Emarsys::Contact.create(3, "john.doe@example.com", stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".update" do
    it "requests contact update with parameters" do
      stub_params = {1 => 'Jane', 2 => "Doe"}
      stub = stub_request(:put, "https://suite5.emarsys.net/api/v2/contact").with(:body => stub_params.merge!({'key_id' => 3, 3 => 'jane.doe@example.com'}).to_json).to_return(standard_return_body)
      Emarsys::Contact.update(3, 'jane.doe@example.com', stub_params)
      stub.should have_been_requested.once
    end
  end
end