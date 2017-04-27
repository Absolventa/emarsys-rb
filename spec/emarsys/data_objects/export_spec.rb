require 'spec_helper'

describe Emarsys::Export do
  describe ".resource" do
    it "requests a single export" do
      expect(
        stub_get('export/123') { Emarsys::Export.resource(123) }
      ).to have_been_requested.once
    end
  end

  describe ".data" do
    it "requests export data" do
      expect(
        stub_get('export/123/data') { Emarsys::Export.data(123) }
      ).to have_been_requested.once
    end
  end

  describe ".filter" do
    it "requests a single export" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/export/filter").to_return(standard_return_body)
      Emarsys::Export.filter(
        filter: 123,
        distribution_method: 'local',
        contact_fields: [1, 3]
      )
      expect(stub).to have_been_requested.once
    end
  end
end
