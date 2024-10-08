require 'spec_helper'

describe Emarsys::Email do
  describe ".collection" do
    it "requests all emails" do
      expect(
        stub_get('email') { Emarsys::Email.collection }
      ).to have_been_requested.once
    end

    it "requests all emails to the given status parameter" do
      expect(
        stub_get('email/?status=3') { Emarsys::Email.collection(:status => 3) }
      ).to have_been_requested.once
    end

    it "requests all emails to the given contactlist parameter" do
      expect(
        stub_get('email/?contactlist=123') { Emarsys::Email.collection(:contactlist => 123) }
      ).to have_been_requested.once
    end

    it "requests all emails - even with combined parameters" do
      expect(
        stub_get('email/?status=3&contactlist=123') { Emarsys::Email.collection(:status => 3, :contactlist => 123) }
      ).to have_been_requested.once
    end
  end

  describe ".resource" do
    it "requests a single email" do
      expect(
        stub_get('email/123') { Emarsys::Email.resource(123) }
      ).to have_been_requested.once
    end
  end

  describe ".create" do
    it "requests email creation" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email").to_return(standard_return_body)
      Emarsys::Email.create
      expect(stub).to have_been_requested.once
    end

    it "requests email creation with parameters" do
      stub_params = {:language => 'de', :name => "Something"}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.create(**stub_params)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".launch" do
    it "requests an email launch" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/launch").to_return(standard_return_body)
      Emarsys::Email.launch(123)
      expect(stub).to have_been_requested.once
    end

    it "requests an email launch with parameters" do
      stub_params = {schedule: "2013-12-01 23:00:00", time_zone: "Europe/Berlin"}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/launch").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.launch(123, schedule: "2013-12-01 23:00:00", time_zone: "Europe/Berlin")
      expect(stub).to have_been_requested.once
    end
  end

  describe ".preview" do
    it "requests an email preview" do
      stub_params = {:version => 'html'}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/preview").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.preview(123, version: 'html')
      expect(stub).to have_been_requested.once
    end
  end

  describe ".send_test_mail" do
    it "requests an email test sending with custom recipient list" do
      stub_params = {recipientlist: 'john.doe@example.com;jane.doe@example.com'}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/123/sendtestmail").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.send_test_mail(123, recipientlist: 'john.doe@example.com;jane.doe@example.com')
      expect(stub).to have_been_requested.once
    end
  end

  describe ".unsubscribe" do
    it "tracks unsubscribes with contact and list details" do
      stub_params = {contact_uid: '1', email_id: '1', launch_list_id: '1'}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/unsubscribe").with(:body => stub_params.to_json).to_return(standard_return_body)

      Emarsys::Email.unsubscribe(**stub_params)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".response_summary" do
    it "requests a single email" do
      stub_params = {
        launch_id: 123,
        start_date: '2013-12-01 23:00:00',
        end_date: '2013-12-02 23:00:00'
      }
      expect(stub_get('email/123/responsesummary/?end_date=2013-12-02%2023:00:00&launch_id=123&start_date=2013-12-01%2023:00:00') {
        Emarsys::Email.response_summary(123, **stub_params) }
      ).to have_been_requested.once
    end
  end

  describe ".responses" do
    it "queries responses" do
      stub_params = { type: "received", campaign_id: 123 }
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/email/responses").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Email.responses(**stub_params)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".responses_result" do
    it "queries responses result" do
      expect(
        stub_get('email/123/responses') { Emarsys::Email.responses_result(123) }
      ).to have_been_requested.once
    end
  end

  describe ".email_launches" do
    it "queries email launches" do
      stub_params = { emailId: 123 }
      stub = stub_request(:post, 'https://api.emarsys.net/api/v2/email/getlaunchesofemail')
      .with(body: stub_params.to_json)
      .to_return(standard_return_body)
      Emarsys::Email.email_launches(123)
      expect(stub).to have_been_requested.once
    end
  end

end
