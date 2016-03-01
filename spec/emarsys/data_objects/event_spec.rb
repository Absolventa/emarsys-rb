require 'spec_helper'

describe Emarsys::Event do
  describe ".collection" do
    it "requests all events" do
      stub_get("event") { Emarsys::Event.collection }.should have_been_requested.once
    end
  end

  describe ".trigger" do
    it "requests event trigger with parameters" do
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/event/123/trigger").with(:body => {'key_id' => 3, 'external_id' => "jane.doe@example.com"}.to_json).to_return(standard_return_body)
      Emarsys::Event.trigger(123, 3, 'jane.doe@example.com')
      stub.should have_been_requested.once
    end

    it "requests event trigger with additional data parameters" do
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/event/123/trigger").with(:body => {'key_id' => 3, 'external_id' => "jane.doe@example.com", :data => {'global' => {'my_placeholder' => 'Something'}}}.to_json).to_return(standard_return_body)
      Emarsys::Event.trigger(123, 3, 'jane.doe@example.com', {'global' => {'my_placeholder' => 'Something'}})
      stub.should have_been_requested.once
    end
  end

  describe ".trigger_multiple" do
    it "requests event trigger with parameters" do
      stub = stub_request(:post, "https://suite5.emarsys.net/api/v2/event/123/trigger").with(:body => {'key_id' => 3, 'external_id' => "", :data => nil, :contacts => [{'external_id' => "jane.doe@example.com"}]}.to_json).to_return(standard_return_body)
      Emarsys::Event.trigger_multiple(123,3,[{'external_id' => 'jane.doe@example.com'}])
      stub.should have_been_requested.once
    end
  end
end
