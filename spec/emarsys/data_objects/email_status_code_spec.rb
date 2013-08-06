require 'spec_helper'

describe Emarsys::EmailStatusCode do
  describe "CODES constant" do
    it "is an array of size 5" do
      expect(Emarsys::EmailStatusCode::CODES.size).to eq(5)
    end
  end

  describe ".collection" do
    it "requests all email_status_codes" do
      expect(Emarsys::EmailStatusCode.collection).to eq(Emarsys::EmailStatusCode::CODES)
    end
  end

  describe ".resource" do
    it "requests a single email status code hash" do
      expect(Emarsys::EmailStatusCode.resource(1)).to eq({'1'   => 'In design'})
    end

    it "returns nil if it cannot find a status code" do
      expect(Emarsys::EmailStatusCode.resource(100)).to eq(nil)
    end
  end
end