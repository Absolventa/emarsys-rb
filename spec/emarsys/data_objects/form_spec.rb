require 'spec_helper'

describe Emarsys::Form do
  describe ".collection" do
    it "requests all languages" do
      stub_get("form") { Emarsys::Form.collection }.should have_been_requested.once
    end
  end
end