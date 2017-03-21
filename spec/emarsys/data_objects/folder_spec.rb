require 'spec_helper'

describe Emarsys::Folder do
  describe ".collection" do
    it "requests all folders" do
      expect(
        stub_get("folder") { Emarsys::Folder.collection }
      ).to have_been_requested.once
    end

    it "requests all folders with parameters" do
      expect(
        stub_get("folder/?folder=3") { Emarsys::Folder.collection(folder: 3) }
      ).to have_been_requested.once
    end
  end
end
