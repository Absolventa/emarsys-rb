require 'spec_helper'

describe Emarsys::File do
  describe ".collection" do
    it "requests all files" do
      stub_get("file") { Emarsys::File.collection }.should have_been_requested.once
    end

    it "requests all files with parameter" do
      stub_get("file/folder=3") { Emarsys::File.collection(:folder => 3) }.should have_been_requested.once
    end
  end
end