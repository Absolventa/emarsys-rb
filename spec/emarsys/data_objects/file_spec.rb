require 'spec_helper'

describe Emarsys::File do
  describe ".collection" do
    it "requests all files" do
      stub_get("file") { Emarsys::File.collection }.should have_been_requested.once
    end

    it "requests all files with parameter" do
      stub_get("file/?folder=3") { Emarsys::File.collection(:folder => 3) }.should have_been_requested.once
    end
  end

  describe ".create" do
    it "requests file creation with parameters" do
      stub_params = {:filename => 'my_file.jpg', :file => 'base_64_encoded_string'}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/file").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::File.create('my_file.jpg', 'base_64_encoded_string')
      stub.should have_been_requested.once
    end

    it "requests file creation with optional folder parameter" do
      stub_params = {:filename => 'my_file.jpg', :file => 'base_64_encoded_string', :folder => 3}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/file").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::File.create('my_file.jpg', 'base_64_encoded_string', 3)
      stub.should have_been_requested.once
    end
  end
end
