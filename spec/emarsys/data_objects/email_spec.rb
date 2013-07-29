require 'spec_helper'

describe Emarsys::Email do
  describe ".collection" do
    it "requests all emails" do
      stub_get('email') { Emarsys::Email.collection }.should have_been_requested.once
    end

    it "requests all emails to the given status parameter" do
      stub_get('email/status=3') { Emarsys::Email.collection({:status => 3}) }.should have_been_requested.once
    end

    it "requests all emails to the given contactlist parameter" do
      stub_get('email/contactlist=123') { Emarsys::Email.collection({:contactlist => 123}) }.should have_been_requested.once
    end

    it "requests all emails - even with combined parameters" do
      stub_get('email/status=3&contactlist=123') { Emarsys::Email.collection({:status => 3, :contactlist => 123}) }.should have_been_requested.once
    end
  end

  describe ".resource" do
    it "requests a single email" do
      stub_get('email/123') { Emarsys::Email.resource(123) }.should have_been_requested.once
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