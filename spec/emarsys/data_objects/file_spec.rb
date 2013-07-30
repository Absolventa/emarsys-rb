require 'spec_helper'

describe Emarsys::File do
  describe ".collection" do
    it "requests all languages" do
      stub_get("file") { Emarsys::File.collection }.should have_been_requested.once
    end
  end
end