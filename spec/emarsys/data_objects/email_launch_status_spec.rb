require 'spec_helper'

describe Emarsys::EmailLaunchStatus do
  describe "CODES constant" do
    it "is an array of size 4" do
      expect(Emarsys::EmailLaunchStatus::CODES.size).to eq(4)
    end
  end

  describe ".collection" do
    it "requests all email_launch_status" do
      expect(Emarsys::EmailLaunchStatus.collection).to eq(Emarsys::EmailLaunchStatus::CODES)
    end
  end

  describe ".resource" do
    it "requests a single email launch status" do
      expect(Emarsys::EmailLaunchStatus.resource(0)).to eq({'0'   => 'Not launched'})
    end

    it "returns nil if it cannot find a launch code" do
      expect(Emarsys::EmailLaunchStatus.resource(100)).to eq(nil)
    end
  end
end
