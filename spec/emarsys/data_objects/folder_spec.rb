require 'spec_helper'

describe Emarsys::Folder do
  describe ".collection" do
    it "requests all languages" do
      stub_get("folder") { Emarsys::Folder.collection }.should have_been_requested.once
    end
  end
end