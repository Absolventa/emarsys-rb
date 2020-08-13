require 'spec_helper'

describe Emarsys::Segment do
  describe ".collection" do
    it "requests all segments" do
      expect(
        stub_get("filter") { Emarsys::Segment.collection }
      ).to have_been_requested.once
    end
    describe ".contacts" do
      it "requests contact data for a given segment" do
        stub = stub_request(:get, "https://api.emarsys.net/api/v2/filter/123/contacts/?limit=2000&offset=0").to_return(standard_return_body)
        Emarsys::Segment.contacts(123, limit: 2000)
        expect(stub).to have_been_requested.once
      end
    end
    describe ".run" do
      it "requests a run for a segment for multiple contacts" do
        expect(
          stub_post("filter/123/runs") { Emarsys::Segment.run(123) }
        ).to have_been_requested.once
      end
    end
    describe ".status" do
      it "requests the status of the given segment run" do
        expect(
          stub_get("filter/runs/333") { Emarsys::Segment.status(333) }
        ).to have_been_requested.once
      end
    end
  end
end
