require 'spec_helper'

describe Emarsys::Language do
  describe ".collection" do
    it "requests all languages" do
      stub_get("language") { Emarsys::Language.collection }.should have_been_requested.once
    end
  end
end