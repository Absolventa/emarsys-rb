require 'spec_helper'

describe Emarsys::Email do
  before :each do
    Emarsys.configure do |config|
      config.api_username = "my_username"
      config.api_password = "my_password"
    end
  end

  describe ".collection" do
    it "returns all emails" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email").to_return(standard_return_body)
      Emarsys::Email.collection
      stub.should have_been_requested.once
    end

    it "returns all emails to the given status parameter" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email/status=3").to_return(standard_return_body)
      Emarsys::Email.collection({:status => 3})
      stub.should have_been_requested.once
    end

    it "returns all emails to the given contactlist parameter" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email/contactlist=123").to_return(standard_return_body)
      Emarsys::Email.collection({:contactlist => 123})
      stub.should have_been_requested.once
    end

    it "returns all emails - even with combined parameters" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email/status=3&contactlist=123").to_return(standard_return_body)
      Emarsys::Email.collection({:status => 3, :contactlist => 123})
      stub.should have_been_requested.once
    end
  end

  describe ".resource" do

  end

end