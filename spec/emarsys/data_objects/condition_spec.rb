require 'spec_helper'

describe Emarsys::Condition do
  before :all do
    stub_emarsys_authentication!
  end

  describe ".collection" do
    it "requests all conditions" do
      stub = stub_request(:get, "https://suite5.emarsys.net/api/v2/condition").to_return(standard_return_body)
      Emarsys::Condition.collection
      stub.should have_been_requested.once
    end
  end
end