require 'spec_helper'

describe Emarsys::Condition do
  describe ".collection" do
    it "requests all conditions" do
      expect(
        stub_get("condition") { Emarsys::Condition.collection }
      ).to have_been_requested.once
    end
  end
end
