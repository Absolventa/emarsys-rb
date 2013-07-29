require 'spec_helper'

describe Emarsys::Email do
  before :all do
    stub_emarsys_authentication!
  end

  describe ".collection" do
    it "requests all emails" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email").to_return(standard_return_body)
      Emarsys::Email.collection
      stub.should have_been_requested.once
    end

    it "requests all emails to the given status parameter" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email/status=3").to_return(standard_return_body)
      Emarsys::Email.collection({:status => 3})
      stub.should have_been_requested.once
    end

    it "requests all emails to the given contactlist parameter" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email/contactlist=123").to_return(standard_return_body)
      Emarsys::Email.collection({:contactlist => 123})
      stub.should have_been_requested.once
    end

    it "requests all emails - even with combined parameters" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email/status=3&contactlist=123").to_return(standard_return_body)
      Emarsys::Email.collection({:status => 3, :contactlist => 123})
      stub.should have_been_requested.once
    end
  end

  describe ".resource" do
    it "requests a single email" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/email/123").to_return(standard_return_body)
      Emarsys::Email.resource(123)
      stub.should have_been_requested.once
    end
  end

  describe ".create" do
    it "requests email creation" do
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/email").to_return(standard_return_body)
      Emarsys::Email.create
      stub.should have_been_requested.once
    end

    it "requests email creation with parameters" do
      stub_params = {:language => 'de', :name => "Something"}
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/email").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.create(stub_params)
      stub.should have_been_requested.once
    end
  end

end