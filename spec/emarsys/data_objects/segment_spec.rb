require 'spec_helper'

describe Emarsys::Segment do
  describe ".collection" do
    it "requests all segments" do
      stub_get("filter") { Emarsys::Segment.collection }.should have_been_requested.once
    end
  end
end