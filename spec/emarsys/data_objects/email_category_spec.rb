require 'spec_helper'

describe Emarsys::EmailCategory do
  describe ".collection" do
    it "requests all email_categories" do
      expect(
        stub_get("emailcategory") { Emarsys::EmailCategory.collection }
      ).to have_been_requested.once
    end
  end
end
