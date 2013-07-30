require 'spec_helper'

describe Emarsys::EmailCategory do
  describe ".collection" do
    it "requests all email_categories" do
      stub_get("emailcategory") { Emarsys::EmailCategory.collection }.should have_been_requested.once
    end
  end
end