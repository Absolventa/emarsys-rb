require 'spec_helper'

describe Emarsys::ContactList do
  describe ".collection" do
    it "requests all contactlists" do
      expect(
        stub_get("contactlist") { Emarsys::ContactList.collection }
      ).to have_been_requested.once
    end
  end
  describe ".contacts" do
    it "requests all contacts in the given contact list" do
      expect(
        stub_get("contactlist/123/") { Emarsys::ContactList.contacts(123) }
      ).to have_been_requested.once
    end
  end
end
