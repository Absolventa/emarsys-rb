require 'spec_helper'

describe Emarsys::FieldMapping do

  it "defines constant ATTRBUTES " do
    Emarsys::FieldMapping::ATTRIBUTES.should be_a(Array)
  end

  it "defines constant ATTRBUTES as an array if hashes" do
    Emarsys::FieldMapping::ATTRIBUTES.should be_a(Array)
    Emarsys::FieldMapping::ATTRIBUTES.map{|elem| elem.should be_a(Hash)}
  end

end