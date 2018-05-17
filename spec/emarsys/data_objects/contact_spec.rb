require 'spec_helper'

describe Emarsys::Contact do
  describe ".create" do
    it "requests contact creation with parameters" do
      stub_params = {1 => 'John', 2 => "Doe"}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact").with(:body => stub_params.merge!({'key_id' => 3, 3 => 'john.doe@example.com'}).to_json).to_return(standard_return_body)
      Emarsys::Contact.create(key_id: 3, key_value: "john.doe@example.com", params: stub_params)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".emarsys_id" do
    it "requests emarsys_id of a contact" do
      stub = stub_request(:get, "https://api.emarsys.net/api/v2/contact/?3=jane.doe@example.com").to_return(standard_return_body)
      Emarsys::Contact.emarsys_id(key_id: 3, key_value: 'jane.doe@example.com')
      expect(stub).to have_been_requested.once
    end
  end

  describe ".update" do
    it "requests contact update with parameters" do
      stub_params = {1 => 'Jane', 2 => "Doe"}
      stub = stub_request(:put, "https://api.emarsys.net/api/v2/contact").with(:body => stub_params.merge!({'key_id' => 3, 3 => 'jane.doe@example.com'}).to_json).to_return(standard_return_body)
      Emarsys::Contact.update(key_id: 3, key_value: 'jane.doe@example.com', params: stub_params)
      expect(stub).to have_been_requested.once
    end
    it "may create non-existing contact" do
      stub_params = {1 => 'Jane', 2 => "Doe"}
      stub = stub_request(:put, "https://api.emarsys.net/api/v2/contact/?create_if_not_exists=1").with(:body => stub_params.merge!({'key_id' => 3, 3 => 'jane.doe@example.com'}).to_json).to_return(standard_return_body)
      Emarsys::Contact.update(key_id: 3, key_value: 'jane.doe@example.com', params: stub_params, create_if_not_exists: true)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".create_batch" do
    it "requests contact batch creation with parameters" do
      stub_params = [{1 => 'Jane', 2 => "Doe"}, {1 => 'Paul', 2 => 'Tester'}]
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact").with(:body => {'key_id' => 3, 'contacts' => stub_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.create_batch(key_id: 3, params: stub_params)
      expect(stub).to have_been_requested.once
    end
    it "transforms identifiers to IDs for each contact parameter set" do
      given_params = [{'_firstname' => 'Jane', '_lastname' => "Doe"}, {'_firstname' => 'Paul', '_lastname' => 'Tester'}]
      expected_params = [{1 => 'Jane', 2 => "Doe"}, {1 => 'Paul', 2 => 'Tester'}]
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact").with(:body => {'key_id' => 3, 'contacts' => expected_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.create_batch(key_id: '_email', params: given_params)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".update_batch" do
    it "requests contact batch update with parameters" do
      stub_params = [{1 => 'Jane', 2 => "Doe"}, {1 => 'Paul', 2 => 'Tester'}]
      stub = stub_request(:put, "https://api.emarsys.net/api/v2/contact").with(:body => {'key_id' => 3, 'contacts' => stub_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.update_batch(key_id: 3, params: stub_params)
      expect(stub).to have_been_requested.once
    end
    it "transforms identifiers to IDs for each contact parameter set" do
      given_params = [{'_firstname' => 'Jane', '_lastname' => "Doe"}, {'_firstname' => 'Paul', '_lastname' => 'Tester'}]
      expected_params = [{1 => 'Jane', 2 => "Doe"}, {1 => 'Paul', 2 => 'Tester'}]
      stub = stub_request(:put, "https://api.emarsys.net/api/v2/contact").with(:body => {'key_id' => 3, 'contacts' => expected_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.update_batch(key_id: '_email', params: given_params)
      expect(stub).to have_been_requested.once
    end
    it "may create non-existing contacts" do
      stub_params = [{1 => 'Jane', 2 => "Doe"}, {1 => 'Paul', 2 => 'Tester'}]
      stub = stub_request(:put, "https://api.emarsys.net/api/v2/contact/?create_if_not_exists=1").with(:body => {'key_id' => 3, 'contacts' => stub_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.update_batch(key_id: 3, params: stub_params, create_if_not_exists: true)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".delete" do
    it "deletes contact" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact/delete").with(:body => {'key_id' => 3, 3 => 'jane.doe@example.com'}.to_json).to_return(standard_return_body)
      Emarsys::Contact.delete(key_id: 3, key_value: 'jane.doe@example.com')
      expect(stub).to have_been_requested.once
    end
  end

  describe ".contact_history" do
    it "requests contact histories" do
      stub_params = [1,2,3]
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact/getcontacthistory").with(:body => {'contacts' => stub_params}.to_json).to_return(standard_return_body)
      Emarsys::Contact.contact_history(contacts: stub_params)
      expect(stub).to have_been_requested.once
    end
  end

  describe ".search" do
    it "requests contact data based on search params" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact/getdata").with(:body => {'keyId' => '3', 'keyValues' => ['jane.doe@example.com'], 'fields' => []}.to_json).to_return(standard_return_body)
      Emarsys::Contact.search(key_id: '3', key_values: ['jane.doe@example.com'])
      expect(stub).to have_been_requested.once
    end
  end

  describe ".query" do
    it "queries contact data based on search params" do
      stub = stub_request(:get, "https://api.emarsys.net/api/v2/contact/query?3=jane.doe@example.com&return=email").to_return(standard_return_body)
      Emarsys::Contact.query(key_id: 3, key_value: 'jane.doe@example.com', return_value: 'email')
      expect(stub).to have_been_requested.once
    end
  end

  describe ".export_registrations" do
    it "requests contact data export based on parameters" do
      stub_params = {distribution_method: 'local', time_range: ["2013-01-01","2013-12-31"], contact_fields: [1,2,3]}
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/contact/getregistrations").with(:body => stub_params.to_json).to_return(standard_return_body)
      Emarsys::Contact.export_registrations(stub_params)
      expect(stub).to have_been_requested.once
    end
  end



  def contact_history(contact_ids_array)
    post account, "contact/getcontacthistory", {'contacts' => contact_ids_array}
  end
end
