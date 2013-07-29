require 'spec_helper'

describe Emarsys::Condition do
  before :all do
    stub_emarsys_authentication!
  end

  describe ".collection" do
    it "requests all conditions" do
      stub_get("condition") { Emarsys::Condition.collection }.should have_been_requested.once
    end
  end
end