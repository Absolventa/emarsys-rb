require 'spec_helper'

describe Emarsys::Segment do
  describe ".collection" do
    it "requests all segments" do
      expect(
        stub_get("filter") { Emarsys::Segment.collection }
      ).to have_been_requested.once
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
