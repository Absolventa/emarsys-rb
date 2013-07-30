require 'spec_helper'

describe Emarsys::Export do
  describe ".resource" do
    it "requests a single export" do
      stub_get('export/123') { Emarsys::Export.resource(123) }.should have_been_requested.once
    end
  end
end