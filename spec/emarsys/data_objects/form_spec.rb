require 'spec_helper'

describe Emarsys::Form do
  describe ".collection" do
    it "requests all languages" do
      expect(
        stub_get("form") { Emarsys::Form.collection }
      ).to have_been_requested.once
    end
  end
end
