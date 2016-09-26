require 'spec_helper'

describe Emarsys::Contact do
  describe ".create" do
    it "requests contact creation with parameters" do
      stub_params = {1 => 'John', 2 => "Doe"}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact").with(:body => stub_params.merge!({'key_id' => 3, 3 => 'john.doe@example.com'}).to_json).to_return(standard_return_body)
      Emarsys::Contact.create(3, "john.doe@example.com", stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".emarsys_id" do
    it "requests emarsys_id of a contact" do
      stub = stub_request(:get, "https://api.emarsys.net/api/v2/contact/?3=jane.doe@example.com").to_return(standard_return_body)
      Emarsys::Contact.emarsys_id(3, 'jane.doe@example.com')
      stub.should have_been_requested.once
    end
  end

  describe ".update" do
    it "requests contact update with parameters" do
      stub_params = {1 => 'Jane', 2 => "Doe"}
      stub = stub_request(:put, "https://api.emarsys.net/api/v2/contact").with(:body => stub_params.merge!({'key_id' => 3, 3 => 'jane.doe@example.com'}).to_json).to_return(standard_return_body)
      Emarsys::Contact.update(3, 'jane.doe@example.com', stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".create_batch" do
    it "requests contact batch creation with parameters" do
      stub_params = [{1 => 'Jane', 2 => "Doe"}, {1 => 'Paul', 2 => 'Tester'}]
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact").with(:body => {'key_id' => 3, 'contacts' => stub_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.create_batch(3, stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".update_batch" do
    it "requests contact batch update with parameters" do
      stub_params = [{1 => 'Jane', 2 => "Doe"}, {1 => 'Paul', 2 => 'Tester'}]
      stub = stub_request(:put, "https://api.emarsys.net/api/v2/contact").with(:body => {'key_id' => 3, 'contacts' => stub_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.update_batch(3, stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".contact_history" do
    it "requests contact histories" do
      stub_params = [1,2,3]
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact/getcontacthistory").with(:body => {'contacts' => stub_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.contact_history(stub_params)
      stub.should have_been_requested.once
    end
  end

  describe ".search" do
    it "requests contact data based on search params" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact/getdata").with(:body => {'keyId' => '3', 'keyValues' => ['jane.doe@example.com'], 'fields' => []}.to_json).to_return(standard_return_body)
      Emarsys::Contact.search('3', ['jane.doe@example.com'])
      stub.should have_been_requested.once
    end
  end

  describe ".export_registrations" do
    it "requests contact data export based on parameters" do
      stub_params = {distribution_method: 'local', time_range: ["2013-01-01","2013-12-31"], contact_fields: [1,2,3]}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact/getregistrations").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Contact.export_registrations(stub_params)
      stub.should have_been_requested.once
    end
  end



  def contact_history(contact_ids_array)
    post "contact/getcontacthistory", {'contacts' => contact_ids_array}
  end
end
