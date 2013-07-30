require 'spec_helper'

describe Emarsys::ContactList do
  describe ".collection" do
    it "requests all contactlists" do
      stub_get("contactlist") { Emarsys::ContactList.collection }.should have_been_requested.once
    end
  end
end