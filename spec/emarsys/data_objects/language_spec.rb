require 'spec_helper'

describe Emarsys::Language do
  describe ".collection" do
    it "requests all languages" do
      expect(
        stub_get("language") { Emarsys::Language.collection }
      ).to have_been_requested.once
    end
  end
end
