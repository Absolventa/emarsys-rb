require 'spec_helper'

describe Emarsys::Email do
  describe ".collection" do
    it "requests all emails" do
      stub_get('email') { Emarsys::Email.collection }.should have_been_requested.once
    end

    it "requests all emails to the given status parameter" do
      stub_get('email/?status=3') { Emarsys::Email.collection({:status => 3}) }.should have_been_requested.once
    end

    it "requests all emails to the given contactlist parameter" do
      stub_get('email/?contactlist=123') { Emarsys::Email.collection({:contactlist => 123}) }.should have_been_requested.once
    end

    it "requests all emails - even with combined parameters" do
      stub_get('email/?status=3&contactlist=123') { Emarsys::Email.collection({:status => 3, :contactlist => 123}) }.should have_been_requested.once
    end
  end

  describe ".resource" do
    it "requests a single email" do
      stub_get('email/123') { Emarsys::Email.resource(123) }.should have_been_requested.once
    end
  end

  describe ".create" do
    it "requests email creation" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email").to_return(standard_return_body)
      Emarsys::Email.create
      stub.should have_been_requested.once
    end

    it "requests email creation with parameters" do
      stub_params = {:language => 'de', :name => "Something"}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.create(stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".launch" do
    it "requests an email launch" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/launch").to_return(standard_return_body)
      Emarsys::Email.launch(123)
      stub.should have_been_requested.once
    end

    it "requests an email launch with parameters" do
      stub_params = {:schedule => "2013-12-01 23:00:00", :time_zone => "Europe/Berlin"}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/launch").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.launch(123, stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".preview" do
    it "requests an email preview" do
      stub_params = {:version => 'html'}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/preview").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.preview(123, 'html')
      stub.should have_been_requested.once
    end
  end

  describe ".send_test_mail" do
    it "requests an email test sending with custom recipient list" do
      stub_params = {:recipientlist => 'john.doe@example.com;jane.doe@example.com'}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/sendtestmail").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.send_test_mail(123, stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".response_summary" do
    it "requests a single email" do
      stub_get('email/123/responsesummary') { Emarsys::Email.response_summary(123) }.should have_been_requested.once
    end
  end



end
